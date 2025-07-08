# frozen_string_literal: true

require "csv"

require "propertree"
require "propertree/missing_data_error"
require "propertree/models/property"
require "propertree/models/street"

module Propertree
  class Application
    def initialize(verbose: false)
      LOG.level = verbose ? Logger::DEBUG : Logger::INFO
      ActiveRecord::Base.logger = LOG
      ActiveRecord::Migration.verbose = verbose
      ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
      Propertree::Models::Property::Migration.migrate(:up)
      Propertree::Models::Street::Migration.migrate(:up)
    end

    def average_price_short_trees(max_height: 10)
      average_price_for_tree_height_range(..max_height)
    end

    def average_price_tall_trees(min_height: 11)
      average_price_for_tree_height_range(min_height..)
    end

    def load_properties(file_path)
      LOG.debug("load: #{file_path}")
      properties_data_from_csv(file_path).each do |property_data|
        create_property_from_csv_row(property_data)
      end
    end

    def load_streets(file_path)
      LOG.debug("load: #{file_path}")
      street_data_from_file(file_path).each do |name, height|
        create_street(name, height)
      end
    end

    private

    def average_price_for_tree_height_range(range)
      raise MissingDataError, "No property data present" unless Propertree::Models::Property.any?

      avg_cents = Propertree::Models::Property.joins(:street)
                                              .where(street: { median_tree_height: range })
                                              .average(:cents)
      cents_to_decimal(avg_cents)
    end

    def cents_to_decimal(cents)
      return 0.00 unless cents

      cents * 0.01
    end

    def properties_data_from_csv(file_path)
      CSV.read(file_path, headers: true, encoding: "ISO-8859-1")
    end

    def create_property_from_csv_row(row)
      street = find_street_for_property(row["Street Name"])
      price_in_cents = parse_price(row["Price"])
      address = row["Address"]

      LOG.debug("loading Property: address=#{address} street=#{street} cents=#{price_in_cents}")
      Propertree::Models::Property.create!(address: address, street: street, cents: price_in_cents)
    end

    def find_street_for_property(street_name)
      Propertree::Models::Street.find_by!(name: street_name)
    end

    def parse_price(price_string)
      price_string.gsub(/\W/, "").to_i
    end

    def street_data_from_file(file_path)
      File.readlines(file_path)
          .select { |line| line.match(/\d/) }
          .map { |line| line.split(":") }
    end

    def create_street(name, height)
      cleaned_name = clean_street_name(name)
      height_value = height.to_i
      LOG.debug("loading Street: name=#{cleaned_name} height=#{height_value}")
      Propertree::Models::Street.create!(name: cleaned_name, median_tree_height: height_value)
    end

    def clean_street_name(name)
      name.strip.gsub('"', "")
    end
  end
end
