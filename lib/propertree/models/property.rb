# frozen_string_literal: true

require "active_record"

module Propertree
  module Models
    class Property < ActiveRecord::Base
      belongs_to :street
      validates :address, presence: true
      validates :cents, numericality: { only_integer: true, greater_than: 0 }
      validates :currency, inclusion: { in: %w[EUR] }

      def price
        cents * 0.01
      end

      class Migration < ActiveRecord::Migration[8.0]
        def up
          create_table :properties, if_not_exists: true do |t|
            t.string :address, index: { name: "idx_unique_address" }, null: false
            t.integer :cents, null: false
            t.string :currency, null: false, default: "EUR"
            t.belongs_to :street, index: { name: "idx_street" }
          end
        end

        def down
          drop_table :properties, if_exists: true
        end
      end
    end
  end
end
