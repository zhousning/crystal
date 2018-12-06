class AddDetailsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses,:details,:string
  end
end
