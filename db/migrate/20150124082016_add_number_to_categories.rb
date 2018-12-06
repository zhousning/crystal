class AddNumberToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :number, :integer
  end
end
