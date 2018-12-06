class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string     :name
      t.string     :phone
      t.integer    :status
      t.references :parent

      t.timestamps
    end
  end
end
