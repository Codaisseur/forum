class AddNotificationSettingToEveryProfile < ActiveRecord::Migration[5.0]
  def change
    Profile.all.map(&:save)
  end
end
