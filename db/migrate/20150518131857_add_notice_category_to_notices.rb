class AddNoticeCategoryToNotices < ActiveRecord::Migration
  def change
    add_column :notices,:notices_category_id,:integer
  end
end
