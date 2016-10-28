require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:asker) { create :user }
  let!(:profile) { create :profile, user: asker }
  let!(:topic) { create :topic }
  let!(:question) { create :question, user: asker, topic: topic}

  describe "members" do
    let!(:answerer1) { create :user }
    let!(:answerer1profile) { create :profile, user: answerer1}
    let!(:answerer2) { create :user }
    let!(:answerer2profile) { create :profile, user: answerer2}

    let!(:answer1) { create :answer, user: answerer1, question: question }
    let!(:answer2) { create :answer, user: answerer2, question: question }
    let!(:answer3) { create :answer, user: answerer2, question: question }

    it "should be unique" do
      expect(question.members).to contain_exactly( answerer1, answerer2 )
    end
  end


  # describe "create notification setting" do
  #
  #
  #
  # end

end
