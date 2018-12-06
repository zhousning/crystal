class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.integer :category
      t.integer :status, :default => Setting.messages.status_unread
      t.references :parent
      t.references :teacher

      t.timestamps
    end
  end
end
