# Preview all emails at http://localhost:3000/rails/mailers/question_mailer
class QuestionMailerPreview < ActionMailer::Preview
  def asker_mail
    QuestionMailer.asker_mail(Question.first)
  end

  def members_mail
    QuestionMailer.members_mail(Question.first)
  end
end
