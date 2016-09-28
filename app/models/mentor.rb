class Mentor < ActiveRecord::Base

  validates_presence_of :name, :start_time, :end_time, :availability, :calendly_url, :competencies

  mount_uploader :avatar, AvatarUploader
end
