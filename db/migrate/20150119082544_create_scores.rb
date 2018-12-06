class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :title
      t.string :content
      t.references :teacher

      t.timestamps
    end
  end
end
