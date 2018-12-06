class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.string     :number
      t.string     :category
      t.integer    :price, null: false, default: 1
      t.integer    :quantity, null: false, default: 1
      t.integer    :discount
      t.string     :subject
      t.string     :trade_no
      t.string     :state, null: false, default: "opening"
      t.references :order

      t.timestamps
    end
  end
end
