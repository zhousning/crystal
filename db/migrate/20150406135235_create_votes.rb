class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :ip
      t.string :sign
      t.references :teacher

      t.timestamps
    end
    add_index :votes, :teacher_id
  end
end
