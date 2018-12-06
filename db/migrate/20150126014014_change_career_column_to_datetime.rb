class ChangeCareerColumnToDatetime < ActiveRecord::Migration
  def change
    change_column :careers, :start_time, :datetime
    change_column :careers, :end_time, :datetime
  end
end
