class AddSessionTo < ActiveRecord::Migration
  def change
    add_column :votes, :session, :string
    add_column :votes, :sign2, :string
  end
end
