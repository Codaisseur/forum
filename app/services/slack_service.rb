require 'slack-notifier'

class SlackService
  include Rails.application.routes.url_helpers

  def initialize(request)
    SlackConfig.new().save if SlackConfig.first.nil?
    @config = SlackConfig.first
    @slack_notifier = Slack::Notifier.new @config.web_hook, channel: @config.channel, username: @config.user_name
    @hostname = request.host_with_port # NOTE Does this behave when in production?
  end

  def slack_notification_new question
    question_url = "#{question_url(only_path: false, host: @hostname, id: question.id)}"
    ping = {
      "fallback": "<!channel> #{question.user.profile.first_name} posted a new question [#{question.topic.title}]",
      "title_link": question_url,
      "image_url": "",
      "thumb_url": "",
      "color": "#C1272D",
      "pretext": "<!channel> #{question.user.profile.first_name} posted a new question [#{question.topic.title}]",
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
      "fallback": "<!channel> #{question.user.profile.first_name} commented on a question.",
      "title_link": question_url,
      "image_url": "",
      "thumb_url": "",
      "color": "#C1272D",
      "pretext": "<!channel> #{question.user.profile.first_name} commented on a question.",
      "title": "#{question.title.capitalize}",
      "text": "Check out the question to see if you can help! :heart:",
      "footer": "Codaisseur Forum",
      "mrkdwn_in": ["text", "pretext"]
    }
    @slack_notifier.ping(attachments: [ping])
  end
end
