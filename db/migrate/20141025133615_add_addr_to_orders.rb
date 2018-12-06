class AddAddrToOrders < ActiveRecord::Migration
  def change
    add_column:orders,:addr,:string
  end
end
