class CreateStudentIdentities < ActiveRecord::Migration
  def change
    create_table :student_identities do |t|
      t.string :school
      t.string :grade
      t.string :major
      t.references :teacher

      t.timestamps
    end
  end
end
