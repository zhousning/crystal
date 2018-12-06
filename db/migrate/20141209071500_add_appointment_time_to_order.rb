class AddAppointmentTimeToOrder < ActiveRecord::Migration
  def change
    add_column :orders,:appointments_time,:datetime
  end
end
