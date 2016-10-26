class Question < ApplicationRecord
  include Filterable
  include IsVotable

  belongs_to :user
  has_many :answers
  # We want members to be unique so we can email them easily
  # We do this by doing '-> {distinct}'... Awesome!
  has_many :members, -> {distinct}, through: :answers, source: :user
  has_many :notification_settings, as: :notifiable
  belongs_to :topic

  validates_presence_of :title, :body, :topic_id

  scope :topic, -> (topic_id) { where topic_id: topic_id }

  def self.search(search)
    where("title ILIKE ? ", "%#{search}%")
  end
end
