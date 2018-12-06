class CreateInfoCategories < ActiveRecord::Migration
  def change
    create_table :info_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
