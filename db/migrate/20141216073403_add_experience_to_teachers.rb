class AddExperienceToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :experience, :string
  end
end
