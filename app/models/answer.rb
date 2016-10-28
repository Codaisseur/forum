class Answer < ApplicationRecord
  include IsVotable

  belongs_to :user
  belongs_to :question

  validates_presence_of :body, :user, :question
  after_create :create_notification_setting

  def create_notification_setting
    if question.notification_settings.where(user: user).length == 0
      wants_emails = user.profile.notification_setting.send_emails
      question.notification_settings.create(user: user, send_emails: wants_emails)
    end
  end
end
