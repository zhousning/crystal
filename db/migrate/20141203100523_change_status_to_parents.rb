class ChangeStatusToParents < ActiveRecord::Migration
  def change
    change_column :parents, :status, :integer, :default=>0
  end
end
