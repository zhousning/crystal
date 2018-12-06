class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :subject
      t.string :second
      t.string :third

      t.timestamps
    end
  end
end
