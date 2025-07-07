# frozen_string_literal: true

FactoryBot.define do
  factory :street, class: "Propertree::Models::Street" do
    sequence(:name) { |n| "foo #{n} street" }
    median_tree_height { 5 }
  end

  factory :property, class: "Propertree::Models::Property" do
    street { build(:street) }
    sequence(:address) { |n| "#{street.name} nr. #{n}" }
    cents { 100_000 }
    currency { "EUR" }
  end
end
