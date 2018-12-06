class AddNumberToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :number, :string
  end
end
