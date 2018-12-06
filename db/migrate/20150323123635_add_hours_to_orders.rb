class AddHoursToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :hours, :integer, :default=>1
    add_column :orders, :total, :integer, :default=>1
  end
end
