class QuestionMailer < ApplicationMailer

  def asker_mail(question)
    # Expose global question variable to work with
    @question = question

    # Get user data from question and latest answer
    asker          = @question.user
    @asker_name    = !asker.profile.nil? ? asker.profile.first_name : asker.email
    answerer       = @question.answers.last.user
    @answerer_name = !answerer.profile.nil? ? answerer.profile.first_name : answerer.email

    # Send a mail to the OP. Only if someone else has answered
    unless answerer == asker
      mail(to: asker.email, subject: "New reply for: #{@question.title}") do |format|
        format.html { render file: 'question_mailer/asker_mail' }
        format.text { render file: 'question_mailer/asker_mail' }
      end
    end
  end

  def members_mail(question)
    # Expose global question variable to work with
    @question = question

    # Get user data from question and latest answer
    asker          = @question.user
    answerer       = @question.answers.last.user
    @answerer_name = !answerer.profile.nil? ? answerer.profile.first_name : answerer.email

    # Send an email to each topic member
    question.members.each do |member|
      @receiver_name = !member.profile.nil? ? member.profile.first_name : member.email
      # Do not send to asker or last answerer
      unless member == asker || member == answerer
        mail(to: member.email, subject: "New reply for: #{@question.title}") do |format|
          format.html { render file: 'question_mailer/members_mail' }
          format.text { render file: 'question_mailer/members_mail' }
        end
      end
    end
  end

end
