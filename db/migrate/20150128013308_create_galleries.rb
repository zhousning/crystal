class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :photo
      t.integer :teacher_id

      t.timestamps
    end
  end
end
