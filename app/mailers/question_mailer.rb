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
      mail(to: asker.email, subject: "New reply for: #{@question.title}")
    end
  end

  def members_mail(question)
    # Expose global question variable to work with
    @question = question

    # Get user data from question and latest answer
    answerer       = @question.answers.last.user
    @answerer_name = !answerer.profile.nil? ? answerer.profile.first_name : answerer.email

    # And send mail to each unique topic member
    question.members.each do |member|
      # Only send to other members not to latest answerer
      unless answerer == member
        @receiver_name = !member.profile.nil? ? member.profile.first_name : member.email
        mail(to: member.email, subject: "New reply for: #{@question.title}")
      end
    end
  end

end
