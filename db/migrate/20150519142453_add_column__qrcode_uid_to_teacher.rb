class AddColumnQrcodeUidToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :qrcode_uid, :string
  end
end
