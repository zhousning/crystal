class AddMyCategoriesToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :my_categories, :string
  end
end
