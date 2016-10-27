require 'slack-notifier'

class SlackService
  include Rails.application.routes.url_helpers

  def initialize(hostname)
    webhook  = ENV["SLACK_WEBHOOK"]
    channel  = '#testing_notifications'
    username = 'Forum Bot'
    @slack_notifier = Slack::Notifier.new webhook, channel: channel, username: username
    @hostname = hostname
  end

  def slack_notification_new question
    @slack_notifier.ping(
      "<!channel> #{question.user.profile.first_name} posted a new question in the Forum!\r\n
      #{question.title}\r\n
      Check out the question to see if you can help! :heart:\r\n
      #{question_url(only_path: false, host: @hostname, id: question.id)}"
    )
  end

  def slack_notification_reply question
    @slack_notifier.ping(
      "<!channel> #{question.members.last.profile.first_name} commented on #{question.title} in the Forum!\r\n
      Check out the question to see if you can help! :heart:\r\n
      #{question_url(only_path: false, host: @hostname, id: question.id)}"
    )
  end
end
