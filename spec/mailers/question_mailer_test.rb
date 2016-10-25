require 'test_helper'

class QuestionMailerTest < ActionMailer::TestCase

  describe "Someone answers a question" do

    let(:asker) { create :user }
    let(:answerer1) { create :user }
    let(:answerer2) { create :user }
    let(:answerer3) { create :user }

    let(:answer1) { create :answer, user: answerer1 }
    let(:answer2) { create :answer, user: answerer2 }
    let(:answer3) { create :answer, user: answerer3 }
    let(:answer4) { create :answer, user: answerer3 }
    let(:answer5) { create :answer, user: asker }

    let(:question) { create :question, user: asker, answers: [answer1, answer2, answer3, answer4, answer5] }

    it "Should send an email to the asker" do

    end

  end

  describe "when someone answers a question, all answerers are sent an email too" do


  end



end
