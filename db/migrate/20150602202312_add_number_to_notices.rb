class AddNumberToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :number, :string
  end
end
