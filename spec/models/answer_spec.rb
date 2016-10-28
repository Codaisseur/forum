require 'rails_helper'

RSpec.describe Answer, type: :model do

  let!(:asker)            { create :user }
  let!(:answerer)         { create :user }
  let!(:answerer2)        { create :user }
  let!(:askerprofile)     { create :profile, user: asker  }
  let!(:answererprofile)  { create :profile, user: answerer  }
  let!(:answerer2profile) { create :profile, user: answerer2 }
  let!(:topic)            { create :topic }
  let!(:question)         { create :question, topic: topic, user: asker }
  let!(:answer)           { create :answer, question: question, user: answerer }
  let!(:answer2)           { create :answer, question: question, user: asker }


  describe "after_create: create notification setting" do

    it "creates a notification setting when a user posts an answer" do
      expect(question.notification_settings.last.user_id).to eq(answerer.id)
    end

    it "does not create a notification_setting for the same answerer twice" do
      expect(question.notification_settings.last.user_id).not_to eq(asker.id)
    end

  end
end
