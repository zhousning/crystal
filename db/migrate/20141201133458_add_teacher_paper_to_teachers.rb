class AddTeacherPaperToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :teacherPaper, :string
    add_column :teachers, :professionalPaper, :string
  end
end
