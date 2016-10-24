# Preview all emails at http://localhost:3000/rails/mailers/question_mailer
class QuestionMailerPreview < ActionMailer::Preview

  def answer_mail
    QuestionMailer.answer_mail(Question.first)
  end

end
