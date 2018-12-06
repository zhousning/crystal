# coding: utf-8

ActiveAdmin.register Order do
  index do
    selectable_column
    column 'ID',:id
    column '课程' do |f|
      if f.courses.size > 0
        link_to "#{f.courses[0].name}",admin_courses_path(:order_course_id=>f.id)
      else
        ""
      end
    end
    column '价格(元)' do |f|
      if f.courses.size > 0
        "#{f.courses[0].price}"
      else
        ""
      end
    end
    column '联系人',:name
    column '联系电话',:phone
    column '预约时间',:appointments_time do |f|
      f.appointments_time.strftime("%Y-%m-%d")
    end
    #column '授课地址',:addr
    #column '老师电话',:teacher_id do |f| 
    #  f.teacher.phone
    #end
    column '老师姓名',:teacher_id do |f| 
      link_to f.teacher.name,admin_teachers_path(:order_teacher_id=>f.teacher.id)
    end
    column '家长' do |f|
      link_to f.parent.name,admin_parents_path(:order_parent_id=>f.parent_id)
    end
    column '科目' do |f|
      if f.courses.size > 0
        "#{f.courses[0].category.second} / #{f.courses[0].category.third} / #{f.courses[0].category.subject}"
      else
        ""
      end
    end
    column '订单状态',:status do |f|
      case f.status
      when Setting.orders.status_none
        Setting.orders.status_none_string
      when Setting.orders.status_trade_created
        Setting.orders.status_trade_created_string
      when Setting.orders.status_parent_paied
        Setting.orders.status_parent_paied_string
      when Setting.orders.status_teacher_paied
        Setting.orders.status_teacher_paied_string
      when Setting.orders.status_trade_success
        Setting.orders.status_trade_success_string
      when Setting.orders.status_trade_failed
        Setting.orders.status_trade_failed_string
      end
    end
    #actions do |f|
    #  link_to("成功",trade_success_admin_order_path(f)) + "  " +
    #  link_to("失败",trade_failed_admin_order_path(f)) + "  " +
    #  link_to("超时",feedback_timeout_admin_order_path(f))
    #end
    default_actions
  end

  menu label: "订单管理", :priority => 3
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter:status,as: :select,collection: proc{get_order_status},label: '选择订单状态'

  form do |f|
    f.inputs "Order Details" do
      f.input :name,:label=>"联系人"
      f.input :phone,:label=>"联系电话"
      f.input :addr,:label=>"授课地址"
      f.input :appointments_time,:label=>"预约时间"
      #f.input :status,:as => :select, :collection =>get_order_status, :label=>"订单状态"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        td order.id
        th "状态："
        td order.status
      end
      row "创建时间：" do
        td order.created_at.strftime('%Y-%m-%d %H:%M:%S')
        th "修改时间："
        td order.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "课程名称：" do 
        td order.courses[0].name 
        th "课程价格："
        td "#{order.courses[0].price} 元/时"
      end
      row '课程类别：' do |f|
        td "#{f.courses[0].category.second} / #{f.courses[0].category.third} / #{f.courses[0].category.subject}"
      end
      row "联系人：" do
        td order.name
        th "联系电话："
        td order.phone
      end
      row '授课地址：' do
        td order.addr
        th "预约时间："
        td order.appointments_time.strftime("%Y-%m-%d")
      end
      row '家长姓名：', :parent_id do |info|
        td link_to info.parent.name,admin_parents_path(:order_parent_id=>info.parent_id)
        th '家长电话：'
        td info.parent.phone
      end
      row '老师姓名：',:teacher_id do |info|
        td link_to info.teacher.name,admin_teachers_path(:order_teacher_id=>info.teacher.id)
        th "老师电话："
        td info.teacher.phone
      end
      row "操作:" do
        td link_to("家长已支付",trade_parent_paied_admin_order_path(order.id)) + "  " + link_to("家教已确认",trade_teacher_paied_admin_order_path(order.id)) + link_to("交易成功",trade_success_admin_order_path(order.id)) + "  " + link_to("交易失败",trade_failed_admin_order_path(order.id))
      end
    end
  end

  member_action :trade_parent_paied do
    order=Order.find(params[:id])
    order.status = Setting.orders.status_parent_paied
    order.save
    redirect_to :controller=>"orders", :action=>"index"
  end

  member_action :trade_teacher_paied do
    order=Order.find(params[:id])
    order.status = Setting.orders.status_teacher_paied
    order.save
    redirect_to :controller=>"orders", :action=>"index"
  end

  member_action :trade_success do
    order=Order.find(params[:id])
    order.status = Setting.orders.status_trade_success
    order.save
    redirect_to :controller=>"orders", :action=>"index"
  end

  member_action :trade_failed do
    order=Order.find(params[:id])
    order.status = Setting.orders.status_trade_failed
    order.save
    redirect_to :controller=>"orders", :action=>"index"
  end

  sidebar "订单状态" do
    ul do
      li "#{Setting.orders.status_none} -> #{Setting.orders.status_none_string}"
      li "#{Setting.orders.status_trade_created} -> #{Setting.orders.status_trade_created_string}"
      li "#{Setting.orders.status_parent_paied} -> #{Setting.orders.status_parent_paied_string}"
      li "#{Setting.orders.status_teacher_paied} -> #{Setting.orders.status_teacher_paied_string}"
      li "#{Setting.orders.status_trade_success} -> #{Setting.orders.status_trade_success_string}"
      li "#{Setting.orders.status_trade_failed} -> #{Setting.orders.status_trade_failed_string}"
    end
  end

  controller do
    def scoped_collection
      if params[:teacher_order_id]
        super.where(:teacher_id=>params[:teacher_order_id])
      elsif params[:parent_order_id]
        super.where(:parent_id=>params[:parent_order_id])
      elsif params[:course_order_id]
          super.joins(:courses).where("courses.id=#{params[:course_order_id]}")
      else
        super
      end
    end
  end

end
