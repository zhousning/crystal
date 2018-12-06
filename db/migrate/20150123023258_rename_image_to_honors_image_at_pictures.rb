class RenameImageToHonorsImageAtPictures < ActiveRecord::Migration
  def change
    rename_column(:pictures,:image,:honors_image)
  end

end
