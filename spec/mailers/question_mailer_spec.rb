require 'rails_helper'

RSpec.describe QuestionMailer, type: :mailer do
  let!(:asker) { create :user }
  let!(:topic) { create :topic }
  let!(:question) { create :question, user: asker, topic: topic}

  describe "Asker answers own question" do
    let!(:answerer1) { create :user }
    let!(:answer1) { create :answer, user: asker, question: question }

    it "Should not send an email to the asker" do
      email = QuestionMailer.asker_mail(question)
      expect(email.to).not_to match [asker.email]
    end
  end

  describe "Another user answers asker's question" do
    let!(:answerer1) { create :user }
    let!(:answer1) { create :answer, user: answerer1, question: question }

    it "Should send an email to the asker" do
      email = QuestionMailer.asker_mail(question)
      expect(email.to).to match [asker.email]
    end
  end

  describe "Asker replies to one answer of another user" do
    let!(:answerer1) { create :user }

    let!(:answer1) { create :answer, user: answerer1, question: question }
    let!(:answer2) { create :answer, user: asker, question: question }

    it "Should an email to the answerer" do
      # NOTE: Because we are looping in the QuestionMailer.member_mail,
      # NOTE: the array 'email.to' will always contain one item.
      email = QuestionMailer.members_mail(question)
      expect(email.to).to match [answerer1.email]
    end
  end

end
