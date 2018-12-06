# coding: utf-8
module TeachersHelper

  def get_teacher_status
    d = [
          [Setting.teachers.status_none, Setting.teachers.status_none_sql],
          [Setting.teachers.status_edit, Setting.teachers.status_edit_sql],
          [Setting.teachers.status_not_pass, Setting.teachers.status_notpass_sql],
          [Setting.teachers.status_pass, Setting.teachers.status_pass_sql]
        ]
  end

  def get_teacher_identity
    identity = [
          [Setting.teachers.identity_student_string,Setting.teachers.identity_student],
          [Setting.teachers.identity_teacher_string,Setting.teachers.identity_teacher]
        ]
  end
  
  def get_teacher_status_string(status)
    if status == Setting.teachers.status_none_sql
      Setting.teachers.status_none
    elsif status == Setting.teachers.status_edit_sql
      Setting.teachers.status_edit
    elsif status == Setting.teachers.status_notpass_sql
      Setting.teachers.status_not_pass
    elsif status == Setting.teachers.status_pass_sql
      Setting.teachers.status_pass
    end
  end
end
