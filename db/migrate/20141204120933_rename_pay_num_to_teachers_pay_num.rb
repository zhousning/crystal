class RenamePayNumToTeachersPayNum < ActiveRecord::Migration
  def change
    rename_column(:teachers,:payNum,:pay_num)
  end
end
