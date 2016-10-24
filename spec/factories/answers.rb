FactoryGirl.define do

  factory :answer do
    body        { Faker::Lorem.sentence(20) }
  end
end
