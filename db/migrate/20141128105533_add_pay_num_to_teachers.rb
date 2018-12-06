class AddPayNumToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :payNum, :string
  end
end
