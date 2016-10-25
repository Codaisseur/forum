class AddProfileToNotificationSettings < ActiveRecord::Migration[5.0]
  def change
    add_reference :notification_settings, :profile, foreign_key: true
  end
end
