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

    # TODO Make an in between table for this!!!
    # TODO Something like topic_member through user
    # Filter duplicate answerers
    other_members = []
    question.answers.each do |answer|
      other_members << answer.user unless other_members.include? answer.user
    end

    # And send mail to each unique topic member
    other_members.each do |member|
      # Only send to other members not to latest answerer
      unless answerer == member
        @receiver_name = !member.profile.nil? ? member.profile.first_name : member.email
        mail(to: member.email, subject: "New reply for: #{@question.title}")
      end
    end
  end

end
