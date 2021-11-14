FactoryBot.define do
  factory :user do
    id { 9999 }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
