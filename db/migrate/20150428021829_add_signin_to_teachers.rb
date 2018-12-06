class AddSigninToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :signdate, :text
    add_column :teachers, :signcount, :integer
  end
end
