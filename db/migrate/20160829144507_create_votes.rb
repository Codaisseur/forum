class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :vote
      t.references :user, foreign_key: true
      t.integer :votable_id
      t.string :votable_type

      t.timestamps
    end
    add_index :votes, :votable_id
    add_index :votes, [:votable_type, :votable_id]
  end
end
