class SlackConfig < ApplicationRecord
  validates_presence_of :web_hook, :channel, :user_name
end
