class AddClickTimeToInformation < ActiveRecord::Migration
  def change
    add_column :information,:click_times,:integer,:default=>0
  end
end
