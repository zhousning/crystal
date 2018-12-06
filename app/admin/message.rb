# coding: utf-8

ActiveAdmin.register Message do
  index do
    column 'ID', :id
    column '标题', :title
    #column '内容', :content
    column '类型' do |f|
      case f.category
      when Setting.messages.category_public
        Setting.messages.category_public_string
      when Setting.messages.category_parent_public
        Setting.messages.category_parent_public_string
      when Setting.messages.category_teacher_public
        Setting.messages.category_teacher_public_string
      when Setting.messages.category_parent
        Setting.messages.category_parent_string
      when Setting.messages.category_teacher
        Setting.messages.category_teacher_string
      end
    end
    column '状态' do |f|
      case f.status
      when Setting.messages.status_created
        Setting.messages.status_created_string
      when Setting.messages.status_unread
        Setting.messages.status_unread_string
      when Setting.messages.status_read
        Setting.messages.status_read_string
      when Setting.messages.status_outdate
        Setting.messages.status_outdate_string
      end
    end
    column '家长' do |f|
      if f.parent
        link_to f.parent.name, admin_parents_path(:message_parent_id=>f.parent_id)
      end
    end
    column '家教' do |f| 
      if f.teacher
        link_to f.teacher.name, admin_teachers_path(:message_teacher_id=>f.teacher.id)
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

  menu label: "消息管理", :priority => 7
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter :title, label:'标题'

  form do |f|
    f.inputs "Message Details" do
      f.input :title, :label=>"标题"
      f.input :content, :label=>"内容"
      f.input :category, :label=>"类型"
      f.input :status, :label=>"状态"
      f.input :parent_id, :label=>"家长ID"
      f.input :teacher_id, :label=>"家教ID"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        message.id
      end
      row "标题：" do
        message.title
      end
      row "内容：" do
        message.content
      end
      row "类型：" do
        case message.category
        when Setting.messages.category_public
          Setting.messages.category_public_string
        when Setting.messages.category_parent_public
          Setting.messages.category_parent_public_string
        when Setting.messages.category_teacher_public
          Setting.messages.category_teacher_public_string
        when Setting.messages.category_parent
          Setting.messages.category_parent_string
        when Setting.messages.category_teacher
          Setting.messages.category_teacher_string
        end
      end
      row "状态：" do
        case message.status
        when Setting.messages.status_created
          Setting.messages.status_created_string
        when Setting.messages.status_unread
          Setting.messages.status_unread_string
        when Setting.messages.status_read
          Setting.messages.status_read_string
        when Setting.messages.status_outdate
          Setting.messages.status_outdate_string
        end
      end
      row '家长' do
        if message.parent
          link_to message.parent.name, admin_parents_path(:message_parent_id=>message.parent_id)
        end
      end
      row "老师姓名：" do
        if message.teacher
          link_to message.teacher.name, admin_teachers_path(:message_teacher_id=>message.teacher_id)
        end
      end
      row "创建时间：" do
        message.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间：" do
        message.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

  sidebar "消息类型", :except => :index do
    ul do
      li "#{Setting.messages.category_public} -> #{Setting.messages.category_public_string}"
      li "#{Setting.messages.category_parent_public} -> #{Setting.messages.category_parent_public_string}"
      li "#{Setting.messages.category_teacher_public} -> #{Setting.messages.category_teacher_public_string}"
      li "#{Setting.messages.category_parent} -> #{Setting.messages.category_parent_string}"
      li "#{Setting.messages.category_teacher} -> #{Setting.messages.category_teacher_string}"
    end
  end

  sidebar "消息状态", :except => :index do
    ul do
      li "#{Setting.messages.status_created} -> #{Setting.messages.status_created_string}"
      li "#{Setting.messages.status_unread} -> #{Setting.messages.status_unread_string}"
      li "#{Setting.messages.status_read} -> #{Setting.messages.status_read_string}"
      li "#{Setting.messages.status_outdate} -> #{Setting.messages.status_outdate_string}"
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
