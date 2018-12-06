class AddJoinStatusToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :join_status, :integer, :default=>0
  end
end
