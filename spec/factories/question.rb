FactoryGirl.define do
  factory :question do
    topic       5
    title       { Faker::Lorem.sentence(1) }
    body        { Faker::Lorem.sentence(20) }
  end
end
