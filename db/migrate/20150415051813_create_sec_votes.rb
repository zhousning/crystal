class CreateSecVotes < ActiveRecord::Migration
  def change
    create_table :sec_votes do |t|
      t.string :ip
      t.string :session
      t.string :sign
      t.string :sign2
      t.references :teacher

      t.timestamps
    end
  end
end
