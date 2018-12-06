class AlertPaperIdImgToTechers < ActiveRecord::Migration
  def change

   rename_column(:teachers,:paperIDImg,:paper_id_img)
   rename_column(:teachers,:paperImg,:paper_img)
   rename_column(:teachers,:professionalPaper,:professional_paper)
   rename_column(:teachers,:teacherPaper,:teacher_paper)
  end

end
