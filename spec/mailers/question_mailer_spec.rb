require 'rails_helper'

RSpec.describe QuestionMailer, type: :mailer do
  let!(:asker)   { create :user, email: "asker@email.com" }
  let!(:askerprofile) { create :profile, user: asker }
  let!(:topic) { create :topic }
  let!(:question) { create :question, user: asker, topic: topic}


  describe "Asker answers own question" do
    let!(:answerer1) { create :user }
    let!(:answer1) { create :answer, user: asker, question: question }

    it "Should not send an email to the asker" do
      email = QuestionMailer.asker_mail(question)
      expect(email.to).to be_nil
    end
    it "Should not have any members" do
      email = QuestionMailer.members_mail(question)
      expect(email.to).to be_nil
    end
  end

  describe "Another user answers asker's question" do
    let!(:answerer1) { create :user }
    let!(:answerer1profile) { create :profile, user: answerer1}
    let!(:answer1) { create :answer, user: answerer1, question: question }

    it "Should send an email to the asker" do
      email = QuestionMailer.asker_mail(question)
      expect(email.to).to match [asker.email]
    end
    it "Should not send an email to the answerer" do
      email = QuestionMailer.members_mail(question)
      expect(email.to).to be_nil
    end
  end

  describe "Another user replies to a thread with multiple answers" do
    let!(:answerer1) { create :user }
    let!(:answerer1profile) { create :profile, user: answerer1}
    let!(:answerer2) { create :user }
    let!(:answerer2profile) { create :profile, user: answerer2}
    let!(:answerer3) { create :user }
    let!(:answerer3profile) { create :profile, user: answerer3}

    let!(:answer1) { create :answer, user: answerer1, question: question }
    let!(:answer3) { create :answer, user: answerer2, question: question }
    let!(:answer4) { create :answer, user: answerer2, question: question }
    let!(:answer6) { create :answer, user: asker, question: question }
    let!(:answer5) { create :answer, user: answerer3, question: question }

    it "Should send an email to the asker" do
      email = QuestionMailer.asker_mail(question)
      expect(email.to).to match [asker.email]
    end
  end

end
