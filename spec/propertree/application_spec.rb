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
      before { create_list(:property, 10, :tall) }

      it "returns zero" do
        expect(app.average_price_short_trees).to eq(0)
      end
    end

    context "with some streets with short trees" do
      before do
        create_list(:property, 5, :short, cents: 1_000)
        create_list(:property, 5, :tall, cents: 2_000)
      end

      it "returns 10 EUR" do
        expect(app.average_price_short_trees).to eq(10)
      end
    end
  end

  describe ".average_price_tall_trees" do
    let(:app) { described_class.new }

    around do |example|
      app
      DatabaseCleaner.cleaning do
        example.run
      end
    end

    context "when there are no records" do
      it "raises an error" do
        expect { app.average_price_tall_trees }.to raise_error(RuntimeError)
      end
    end

    context "with no streets with tall trees" do
      before { create_list(:property, 10, :short) }

      it "returns zero" do
        expect(app.average_price_tall_trees).to eq(0)
      end
    end

    context "with some streets with tall trees" do
      before do
        create_list(:property, 5, :short, cents: 1_000)
        create_list(:property, 5, :tall, cents: 2_000)
      end

      it "returns 20 EUR" do
        expect(app.average_price_tall_trees).to eq(20)
      end
    end
  end
end
