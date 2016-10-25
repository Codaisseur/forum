class AddMemberGetsRepliesToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :member_gets_replies, :boolean
  end
end
