class AddQrcodeToInformation < ActiveRecord::Migration
  def change
    add_column :information, :qrcode_uid, :string
  end
end
