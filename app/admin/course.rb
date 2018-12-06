# coding: utf-8

ActiveAdmin.register Course do
  index do
    column 'ID',:id
    column '课程名称',:name
    column '科目分类',:category_id do |f|
      f.category.second + " / " + f.category.third + " / " + f.category.subject
    end
    column '授课时期' do |f|
      case f.period
      when Setting.courses.period_normal
        Setting.courses.period_normal_string
      when Setting.courses.period_vacation
        Setting.courses.period_vacation_string
      when Setting.courses.period_all
        Setting.courses.period_all_string
      end
    end
    column "授课老师" do |f|
       link_to f.teacher.name,admin_teachers_path(:course_teacher_id=>f.teacher_id) if f.teacher
    end
    #column '经验/年',:experence
    #column '授课模式',:mode
    #column '授课时长',:length
    column '课时费用(元)',:price
    column '订单数量' do |f|
      span f.orders.size
      span link_to "(查看)",admin_orders_path(:course_order_id=>f.id)
    end
    column "创建时间",:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    default_actions
  end

  menu label: "课程管理", :priority => 4
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter :name,label:'课程名称'

  form do |f|
    f.inputs "Course Details" do
      f.input :name,:label=>"课程名称"
      f.input :mode,:label=>"授课模式"
      f.input :length,:label=>"授课时长"
      f.input :price,:label=>"课时费用"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        td course.id
      end
      row "课程名称：" do
        td course.name
      end
      row '科目分类：' do
        td "#{course.category.second}/#{course.category.third}/#{course.category.subject}"
        th "授课时期："
        case course.period
        when Setting.courses.period_normal
          td Setting.courses.period_normal_string
        when Setting.courses.period_vacation
          td Setting.courses.period_vacation_string
        when Setting.courses.period_all
          td Setting.courses.period_all_string
        end
      end
      row "老师姓名：" do
        td link_to course.teacher.name,admin_teachers_path(:course_teacher_id=>course.teacher_id) if course.teacher
      end
      row "授课经验：" do 
        td course.experence
        th "授课模式："
        td course.mode 
      end
      row "授课时长：" do
        td course.length
        th "课时费用："
        td "#{course.price} 元/时"
      end
      row "创建时间：" do
        td course.created_at
        th "更新时间："
        td course.updated_at
      end
    end
  end

  controller do
    def scoped_collection
      if params[:teacher_course_id]
        super.where(:teacher_id=>params[:teacher_course_id])
      elsif params[:order_course_id]
        super.joins(:orders).where("orders.id=#{params[:order_course_id]}")
      else
        super
      end
    end
  end

end
