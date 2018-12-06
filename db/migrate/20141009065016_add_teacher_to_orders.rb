class AddTeacherToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :teacher_id, :integer
  end
end
