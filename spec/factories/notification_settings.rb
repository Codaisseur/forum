FactoryGirl.define do
  factory :notification_setting do
    user nil
    asker_sees_replies false
    member_sees_replies false
  end
end
