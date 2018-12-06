class CreateHonors < ActiveRecord::Migration
  def change
    create_table :honors do |t|
      t.string :title
      t.text :content
      t.references :teacher

      t.timestamps
    end
  end
end
