class AddPaperToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :paperImg, :string
    add_column :teachers, :paperIDImg, :string
  end
end
