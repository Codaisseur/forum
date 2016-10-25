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

    # Get array of member emails
    member_emails = []
    question.members.each do |member|
      if member.email != answerer.email && member != asker
        member_emails << member.email
      end
    end
    mail(to: member_emails, subject: "New reply for: #{@question.title}") do |format|
      format.html { render file: 'question_mailer/members_mail' }
      format.text { render file: 'question_mailer/members_mail' }
    end
  end

end
