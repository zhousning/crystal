class AddPositionToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :position, :integer
  end
end
