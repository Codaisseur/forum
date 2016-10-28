require 'rails_helper'

RSpec.describe Profile, type: :model do

  let!(:user)     { create :user }
  let!(:profile)  { create :profile, user: user }


  describe "after_create: create notification setting" do

    it "creates a notification setting when profile is created" do
      expect(profile.notification_setting).not_to be_nil
    end

    it "send the attribute send_emails default to true" do
      expect(profile.notification_setting.send_emails).to eq(true)
    end

  end





end
