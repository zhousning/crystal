class AddQuotesToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers,:quotes,:string
  end
end
