class CreateTeacherIdentities < ActiveRecord::Migration
  def change
    create_table :teacher_identities do |t|
      t.string :school
      t.string :grade
      t.string :subject
      t.references :teacher

      t.timestamps
    end
  end
end
