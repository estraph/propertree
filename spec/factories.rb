# frozen_string_literal: true

FactoryBot.define do
  factory :street, class: "Propertree::Models::Street" do
    sequence(:name) { |n| "foo #{n} street" }

    trait :short do
      median_tree_height { 10 }
    end

    trait :tall do
      median_tree_height { 11 }
    end
  end

  factory :property, class: "Propertree::Models::Property" do
    street factory: %i[street short]
    sequence(:address) { |n| "#{street.name} nr. #{n}" }
    cents { 1_000 }
    currency { "EUR" }

    trait :short do
      street factory: %i[street short]
    end

    trait :tall do
      street factory: %i[street tall]
    end
  end
end
