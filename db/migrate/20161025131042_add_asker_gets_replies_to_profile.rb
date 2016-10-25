class AddAskerGetsRepliesToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :asker_gets_replies, :boolean
  end
end
