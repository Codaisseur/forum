class CreateNotificationSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_settings do |t|
      t.references :user, foreign_key: true
      t.boolean :asker_sees_replies
      t.boolean :member_sees_replies

      t.timestamps
    end
  end
end
