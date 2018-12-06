# coding: utf-8

ActiveAdmin.register Vote do
  index do
    column 'ID', :id
    column 'IP', :ip
    column 'SIGN', :sign
    column "家教姓名" do |f|
       link_to f.teacher.name, admin_teachers_path(:vote_teacher_id=>f.teacher_id)
    end
    column "创建时间",:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间",:updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    default_actions
  end

  menu label: "投票管理", :priority => 9
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter :ip, label:'IP'

  form do |f|
    f.inputs "Vote Details" do
      f.input :ip, :label=>"IP"
      f.input :sign, :label=>"SIGN"
      f.input :teacher_id, :label=>"家教ID"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        vote.id
      end
      row "IP：" do
        vote.ip
      end
      row "SIGN：" do
        vote.sign
      end
      row "家教姓名：" do
        link_to vote.teacher.name, admin_teachers_path(:vote_teacher_id=>vote.teacher_id)
      end
      row "创建时间：" do
        vote.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间：" do
        vote.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

  controller do
    def scoped_collection
      if params[:teacher_order_id]
        super.where(:teacher_id=>params[:teacher_order_id])
      elsif params[:course_order_id]
          super.joins(:courses).where("courses.id=#{params[:course_order_id]}")
      elsif params[:parent_order_id]
        super.where(:parent_id=>params[:parent_order_id])
      else
        super
      end
    end
  end

end
