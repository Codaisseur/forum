class CreateMentors < ActiveRecord::Migration[5.0]
  def change
    create_table :mentors do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.string :availability
      t.string :calendly_url
      t.string :avatar

      t.timestamps
    end
  end
end
