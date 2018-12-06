class AddImageToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :image, :string
  end
end
