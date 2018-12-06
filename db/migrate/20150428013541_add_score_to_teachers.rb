class AddScoreToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :score, :integer, :default=>0
  end
end
