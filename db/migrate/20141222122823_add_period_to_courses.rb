class AddPeriodToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :period, :integer, :default=>0
  end
end
