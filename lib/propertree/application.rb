# frozen_string_literal: true

require "csv"
require "debug"

require "propertree"
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
      avg = Propertree::Models::Property.joins(:street).where("streets.median_tree_height <= #{max_height}").average(:cents)
      raise "no data loaded!" unless avg

      avg * 0.01
    end

    def average_price_tall_trees(min_height: 11)
      avg = Propertree::Models::Property.joins(:street).where("streets.median_tree_height >= #{min_height}").average(:cents)
      raise "no data loaded!" unless avg

      avg * 0.01
    end

    def load_properties(file_path)
      LOG.debug("load: #{file_path}")
      CSV.foreach(file_path, headers: true, encoding: "ISO-8859-1") do |row|
        address = row["Address"]
        # assuming the "cleaned" street names in both files match exactly
        street = Propertree::Models::Street.find_by!(name: row["Street Name"])
        # remove any non-alphanumeric characters, including punctuation
        cents = row["Price"].gsub(/\W/, "").to_i
        LOG.debug("loading Property: address=#{address} street=#{street} cents=#{cents}")
        Propertree::Models::Property.create!(address: address, street: street, cents: cents)
      end
    end

    def load_streets(file_path)
      LOG.debug("load: #{file_path}")
      content = File.read(file_path)
      # grep-ish: filter out lines which have a numeric value
      # this makes an assumption about the file format having key-value pairs on separate lines
      content.lines.select { |l| l.match(/\d/) }.map { |l| l.split(":") }.each do |name, height|
        name = name.strip.gsub(/"/, "")
        height = height.to_i
        LOG.debug("loading Street: name=#{name} height=#{height}")
        Propertree::Models::Street.create!(name: name, median_tree_height: height)
      end
    end
  end
end
