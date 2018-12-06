class RenamePayNumPayNumToParents < ActiveRecord::Migration
  def change
    rename_column(:parents,:payNum,:pay_num)
  end

end
