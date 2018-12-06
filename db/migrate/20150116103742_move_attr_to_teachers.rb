class MoveAttrToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :period, :integer, :default=>0
    add_column :teachers, :teaching_age, :integer, :default=>0

    add_column :appointments, :teacher_id, :integer

    #remove_column :courses, :period
    #remove_column :courses, :experence

    #remove_column :appointments, :course_id
  end
end
