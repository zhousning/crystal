class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :course
      t.references :order

      t.timestamps
    end

    add_index :line_items, :course_id
    add_index :line_items, :order_id
  end
end
