class CreateSlackConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_configs do |t|
      t.string :web_hook
      t.string :channel
      t.string :user_name

      t.timestamps
    end
  end
end
