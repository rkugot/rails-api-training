FactoryBot.define do
  factory :source_provider do
    name { Faker::Name.unique.name }
    url { Faker::Internet.unique.url }
    address { Faker::Address.unique.street_address }
    active { true }

    factory :noactive_source_provider do
      active { false }
    end
  end
end
