FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.characters(number: 8) }
  end
end
