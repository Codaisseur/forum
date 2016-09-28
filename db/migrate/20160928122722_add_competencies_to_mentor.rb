class AddCompetenciesToMentor < ActiveRecord::Migration[5.0]
  def change
    add_column :mentors, :competencies, :string
  end
end
