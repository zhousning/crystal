class AddTradecodeToLineItems < ActiveRecord::Migration
  def change
     add_column :line_items, :tradecode, :string
  end
end
