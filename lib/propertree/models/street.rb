# frozen_string_literal: true

require "active_record"

module Propertree
  module Models
    class Street < ActiveRecord::Base
      has_many :properties
      validates :name, presence: true, uniqueness: true, format: { with: /\A[a-z_]+\z/, message: "only snake_case allowed" }
      validates :median_tree_height, numericality: { greater_than_or_equal_to: 0 }

      class Migration < ActiveRecord::Migration[8.0]
        def up
          create_table :streets, if_not_exists: true do |t|
            t.string :name, index: { unique: true, name: "idx_unique_street_name" }, null: false
            t.integer :median_tree_height, index: { name: "idx_median_tree_height" }, null: false
          end
        end

        def down
          drop_table :streets, if_exists: true
        end
      end
    end
  end
end
