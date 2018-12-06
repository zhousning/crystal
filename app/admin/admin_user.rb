# coding: utf-8

ActiveAdmin.register AdminUser do
  index do
    column "邮箱", :email
    column "当前登录时间", :current_sign_in_at do |t|
      t.current_sign_in_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "上次登录时间", :last_sign_in_at do |t|
      t.last_sign_in_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "登录次数", :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  menu label: "管理员", :priority => 11
end
