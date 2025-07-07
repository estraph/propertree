# frozen_string_literal: true

RSpec.describe Propertree do
  it "has a version number" do
    expect(Propertree::VERSION).not_to be_nil
  end

  it "has a logger" do
    expect(Propertree::LOG).to be_a Logger
  end
end
