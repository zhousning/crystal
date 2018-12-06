# coding: utf-8

ActiveAdmin.register Category do
  index do
    column 'ID', :id
    column '科目', :subject
    column '一级', :second
    column '二级', :third
    column '排序', :number
    column "创建时间",:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间",:updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    default_actions
  end

  menu label: "科目管理", :priority => 2
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter :subject, label:'科目'

  form do |f|
    f.inputs "Category Details" do
      f.input :subject, :label=>"科目"
      f.input :second, :label=>"一级"
      f.input :third, :label=>"二级"
      f.input :number, :label=>"排序"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        category.id
      end
      row "科目：" do
        category.subject
      end
      row "一级：" do
        category.second
      end
      row "二级：" do
        category.third
      end
      row "排序：" do
        category.number
      end
      row "创建时间：" do
        category.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间：" do
        category.updated_at.strftime('%Y-%m-%d %H:%M:%S')
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
