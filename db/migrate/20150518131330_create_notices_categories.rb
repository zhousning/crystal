class CreateNoticesCategories < ActiveRecord::Migration
  def change
    create_table :notices_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
