class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.date :start_time
      t.date :end_time
      t.string :child_name
      t.string :school
      t.string :subject
      t.string :before_score
      t.string :after_score
      t.text :content
      t.references :teacher

      t.timestamps
    end
  end
end
