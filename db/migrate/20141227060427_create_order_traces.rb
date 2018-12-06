class CreateOrderTraces < ActiveRecord::Migration
  def change
    create_table :order_traces do |t|
      t.string :p_content
      t.string :t_content
      t.string :p_operator
      t.string :t_operator
      t.integer :status
      t.references :order

      t.timestamps
    end
  end
end
