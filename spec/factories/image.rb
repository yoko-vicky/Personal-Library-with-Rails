FactoryBot.define do
  factory :image do
    user_id { 9999 }
    name { Faker::Lorem.characters(number: 10) }
    file { Faker::File.file_name(ext: 'jpg') }
  end
end
