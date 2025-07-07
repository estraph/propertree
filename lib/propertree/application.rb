# frozen_string_literal: true

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

    def load_property_price_csv(file_path)
      LOG.debug("load: #{file_path}")
    end

    def load_tree_height_json(file_path)
      LOG.debug("load: #{file_path}")
    end
  end
end
