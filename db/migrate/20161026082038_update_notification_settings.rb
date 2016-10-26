class UpdateNotificationSettings < ActiveRecord::Migration[5.0]
  def change
    remove_column :notification_settings, :asker_sees_replies
    remove_column :notification_settings, :member_sees_replies
    remove_reference :notification_settings, :profile

    # Specify custom name else name would be too long
    add_reference :notification_settings, :notifiable, polymorphic: true, index: {name: :idx_notification_settings_on_notifiable_type_and_id}
    add_column :notification_settings, :send_emails, :boolean, default: true
  end
end
