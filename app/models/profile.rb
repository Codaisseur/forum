class Profile <  ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_one :notification_preferences, as: :notifiable

  def full_name
    self.first_name + " " + self.last_name
  end

  mount_uploader :avatar, AvatarUploader

  def self.search(search)
    where("first_name ILIKE ? ", "%#{search}%")
  end
end
