class AddStudyCaseToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :study_case, :text
  end
end
