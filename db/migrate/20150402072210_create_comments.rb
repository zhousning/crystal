class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :total
      t.integer :desc
      t.integer :attitude
      t.integer :speed
      t.string :content
      t.integer :category
      t.references :teacher
      t.references :parent

      t.timestamps
    end
  end
end
