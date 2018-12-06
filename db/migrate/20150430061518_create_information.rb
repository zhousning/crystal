class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :title
      t.text :content
      t.string :img
      t.string :name
      t.string :phone
      t.string :qq
      t.string :weixin
      t.string :number
      t.references :info_category

      t.timestamps
    end
  end
end
