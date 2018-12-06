class AddPayNumToParents < ActiveRecord::Migration
  def change
    add_column :parents,:payNum,:string
  end
end
