class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string     :name
      t.integer    :experence
      t.string     :mode
      t.integer    :length
      t.string     :price
      t.integer    :status
      t.references :category
      t.references :teacher

      t.timestamps
    end
  end
end
