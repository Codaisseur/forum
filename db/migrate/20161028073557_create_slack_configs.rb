class CreateSlackConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_configs do |t|
      t.string :web_hook, default: "https://hooks.slack.com/services/"
      t.string :channel, default: "channel"
      t.string :user_name, default: "bot"

      t.timestamps
    end
  end
end
