class Profile <  ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_one :notification_setting, as: :notifiable
  accepts_nested_attributes_for :notification_setting
  after_save :create_notification_setting

  def full_name
    self.first_name + " " + self.last_name
  end

  mount_uploader :avatar, AvatarUploader

  def self.search(search)
    where("first_name ILIKE ? ", "%#{search}%")
  end

  def create_notification_setting
    return if notification_setting.present?
    build_notification_setting.save
  end
end
