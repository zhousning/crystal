class ModifyOrdersStatus < ActiveRecord::Migration
  def change
    change_column :orders, :status, :integer, :null => false, :default => Setting.orders.status_none
  end
end
