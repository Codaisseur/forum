FactoryGirl.define do
  factory :profile do
    first_name      { Faker::Pokemon.name }
    last_name       { Faker::Pokemon.name }
    bio             { Faker::Lorem.sentence(1) }
  end
end
