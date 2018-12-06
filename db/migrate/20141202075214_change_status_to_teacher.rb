class ChangeStatusToTeacher < ActiveRecord::Migration
  def change
    change_column :teachers,:status,:integer,:default=>0
  end

end
