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
    question_url = "#{question_url(only_path: false, host: @hostname, id: question.id)}"
    ping = {
      "fallback": question_url,
      "title_link": question_url,
      "image_url": "",
      "thumb_url": "",
      "color": "#c1272d",
      "pretext": "<!channel> #{question.user.profile.first_name} posted a new question!",
      "title": "#{question.title.capitalize}",
      "text": "Check out the question to see if you can help! :heart:",
      "footer": "Codaisseur Forum",
      "mrkdwn_in": ["text", "pretext"]
    }
    @slack_notifier.ping(attachments: [ping])
  end

  def slack_notification_reply question
    question_url = "#{question_url(only_path: false, host: @hostname, id: question.id)}"
    ping = {
      "fallback": question_url,
      "title_link": question_url,
      "image_url": "",
      "thumb_url": "",
      "color": "#c1272d",
      "pretext": "<!channel> #{question.user.profile.first_name} commented on a question.",
      "title": "#{question.title.capitalize}",
      "text": "Check out the question to see if you can help! :heart:",
      "footer": "Codaisseur Forum",
      "mrkdwn_in": ["text", "pretext"]
    }
    @slack_notifier.ping(attachments: [ping])
  end
end
