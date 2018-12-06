class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :province
      t.string :city
      t.string :district
      t.references :teacher
      t.references :parent
      t.references :order

      t.timestamps
    end
  end
end
