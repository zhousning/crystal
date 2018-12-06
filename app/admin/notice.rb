# coding: utf-8

ActiveAdmin.register Notice do
  index do
    column 'ID', :id
    column '标题', :title
    #column '内容', :content
    column '类型' do |f|
      # case f.category
      # when Setting.notices.category_news
      #   Setting.notices.category_news_string
      # end
      if f.notices_category
        f.notices_category.title
      end
    end
    column "创建时间",:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间",:updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    default_actions
  end

  menu label: "新闻管理", :priority => 8
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter :title, label:'标题'

  form do |f|
    f.inputs "Notice Details" do
      f.input :title, :label=>"标题"
      f.input :content, :label=>"内容"
      f.input :category, :label=>"类型"
      f.input :notices_category_id,:as=>:select, :collection=>NoticesCategory.all.map {|x| [x.title,x.id]},:label=>"新闻类型"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        notice.id
      end
      row "标题：" do
        notice.title
      end
      row "内容：" do
        notice.content
      end
      row "类型：" do
       # case notice.category
       # when Setting.notices.category_news
       #   Setting.notices.category_news_string
       # end
        if notice.notices_category
          notice.notices_category.title
        end
      end
      row "创建时间：" do
        notice.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间：" do
        notice.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

  sidebar "新闻类型", :except => :index do
    ul do
      li "#{Setting.notices.category_news} -> #{Setting.notices.category_news_string}"
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
