class Answer < ApplicationRecord
  include IsVotable

  belongs_to :user
  belongs_to :question

  validates_presence_of :body, :user, :question
  after_create :create_notification_setting

  def create_notification_setting
    wants_emails = user.profile.notification_setting.send_emails
    notification_setting = question.notification_settings.where(user_id: user.id)
    notification_setting.create(send_emails: wants_emails)
  end

end
