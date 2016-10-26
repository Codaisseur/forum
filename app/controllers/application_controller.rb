class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_profile
  before_action :init_slack_notifier

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_path
  end

  def slack_notification_new question
    @slack_notifier.ping(
      "<!channel> #{question.user.profile.first_name} posted a new question in the Forum!\r\n
      #{question.title}\r\n
      Check out the question to see if you can help! :heart:\r\n
      #{question_url(question)}"
    )
  end

  def slack_notification_reply question
    @slack_notifier.ping(
      "<!channel> #{question.members.last.profile.first_name} commented on #{question.title} in the Forum!\r\n
      Check out the question to see if you can help! :heart:\r\n
      #{question_url(question)}"
    )
  end

  def check_profile
    return unless user_signed_in?
    return if current_user.profile.present? || devise_controller?
    return if request.path.match(/^\/profile/)
    redirect_to new_profile_path, notice: "Please create a profile first"
  end

  private
  def init_slack_notifier
    webhook  = ENV["SLACK_WEBHOOK"]
    channel  = '#testing_notifications'
    username = 'Forum Bot'
    @slack_notifier = Slack::Notifier.new webhook, channel: channel, username: username
  end

 "https://hooks.slack.com/services/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"
end
