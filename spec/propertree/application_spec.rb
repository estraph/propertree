# frozen_string_literal: true

require "database_cleaner/active_record"

require "propertree/application"

RSpec.describe Propertree::Application do
  describe ".initialize" do
    it "initializes an empty streets table" do
      described_class.new
      expect(Propertree::Models::Street.count).to be(0)
    end

    it "initializes an empty properties table" do
      described_class.new
      expect(Propertree::Models::Property.count).to be(0)
    end

    context "when the verbose flag is false" do
      before do
        Propertree::LOG.level = Logger::ERROR
        ActiveRecord::Migration.verbose = true
      end

      it "sets the log level to INFO" do
        described_class.new(verbose: false)
        expect(Propertree::LOG.level).to be(Logger::INFO)
      end

      it "disables ActiveRecord verbosity" do
        described_class.new(verbose: false)
        expect(ActiveRecord::Migration.verbose).to be(false)
      end
    end

    context "when the verbose flag is true" do
      before { Propertree::LOG.level = Logger::ERROR }

      it "sets the log level to DEBUG" do
        described_class.new(verbose: true)
        expect(Propertree::LOG.level).to be(Logger::DEBUG)
      end

      it "enables ActiveRecord verbosity" do
        described_class.new(verbose: true)
        expect(ActiveRecord::Migration.verbose).to be(true)
      end
    end
  end

  describe ".average_price_short_trees" do
    let(:app) { described_class.new }

    around do |example|
      app
      DatabaseCleaner.cleaning do
        example.run
      end
    end

    context "when there are no records" do
      it "raises an error" do
        expect { app.average_price_short_trees }.to raise_error(RuntimeError)
      end
    end

    context "with no streets with short trees" do
      before do
        properties = build_list(:property, 10)
        properties.each do |property|
          property.street.median_tree_height = 11
          property.street.save
          property.save
        end
      end

      it "returns zero" do
        expect(app.average_price_short_trees).to be(0.00)
      end
    end
  end
end
