# coding: utf-8

ActiveAdmin.register NoticesCategory do
  index do
    column 'ID', :id
    column '名称', :title
    column "创建时间",:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间",:updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    default_actions
  end

  menu label: "新闻类型", :priority => 12
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter :subject, label:'科目'

  form do |f|
    f.inputs "Info Category Details" do
      f.input :title, :label=>"名称"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        notices_category.id
      end
      row "名称：" do
        notices_category.title
      end
      row "创建时间：" do
        notices_category.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间：" do
        notices_category.updated_at.strftime('%Y-%m-%d %H:%M:%S')
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
