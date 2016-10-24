class QuestionMailer < ApplicationMailer

  def answer_mail(question)
    debugger
    # Get question data
    @question      = question

    @asker         = @question.user
    @asker_name    = !@asker.profile.nil? ? @asker.profile.first_name : @asker.email
    @answerer      = @question.answers.last.user
    @answerer_name = !@answerer.profile.nil? ? @answerer.profile.first_name : @answerer.email

    # TODO filter duplicate answerers
    # TODO send mail to each topic member
    question.answers.each do |answer|

    end

    mail(to: @asker.email, subject: "New reply for: #{@question.title}")
  end

end
