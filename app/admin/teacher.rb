# coding: utf-8

ActiveAdmin.register Teacher do

  index do 
    selectable_column
    column "ID",:id
    column "姓名",:name
    column "电话",:phone
    #column "支付宝",:pay_num
    column "身份" do |t|
      if t.identity == Setting.teachers.identity_student
        Setting.teachers.identity_student_string
      elsif t.identity == Setting.teachers.identity_teacher
        Setting.teachers.identity_teacher_string
      end
    end
    column "课程数量" do |f|
      span "#{f.courses.size}"
      span link_to '(查看)', admin_courses_path(:teacher_course_id=>f.id)
    end
    column "订单数量" do |f|
      span "#{f.orders.size}"
      span link_to '(查看)',admin_orders_path(:teacher_order_id=>f.id)
    end
    column '登录次数',:sign_in_count
    column "注册时间",:created_at,:sortable=>:created_at do |t|
      t.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间",:updated_at,:sortable=>:updated_at do |t|
      t.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column '评分',:score
    column"状态",:status do |info| 
      case info.status
      when Setting.teachers.status_pass_sql
       Setting.teachers.status_pass
      when Setting.teachers.status_notpass_sql
        Setting.teachers.status_not_pass
      when Setting.teachers.status_edit_sql
        Setting.teachers.status_edit
      when Setting.teachers.status_none_sql
        Setting.teachers.status_none
      end
    end
    #actions do |post|
    #  link_to(Setting.teachers.status_pass,teacherPass_admin_teacher_path(post))+"  "+
    #  link_to(Setting.teachers.status_not_pass,teacherNotPass_admin_teacher_path(post))
    #end
    default_actions
  end

  menu label: "老师管理", :priority => 6
  config.per_page = 20
  config.sort_order = 'id_desc'
  #config.sort_order = 'status_asc'

  filter :name,label:'家教姓名'
  filter :phone,label:'家教电话'
  filter :status,as: :select, collection: proc{get_teacher_status},label: '请选择验证状态'

  form do |f|
    f.inputs "User Details" do
      f.input :name,:label=>"姓名"
      f.input :score,:label=>"评分"
      f.input :sex,:label=>"性别"
      f.input :age,:label=>"年龄"
      f.input :phone,:label=>"电话"
      f.input :email,:label=>"Email"
      f.input :pay_num,:label=>"支付宝"
      f.input :teaching_age,:label=>"实际教龄:"
      f.input :period,:label=>"授课时期:"
      f.input :quotes,:label=>"教学理念:"
      f.input :my_categories,:label=>"教学科目:"
      f.input :hobby,:label=>"个人爱好:"
      f.input :introduction,:label=>"个人经验:"
      f.input :experience,:label=>"过往经历:"
      f.input :identity,:as=>:select, :collection=>get_teacher_identity,:label=>"注册身份"
    end
    f.actions
  end

  show do
    attributes_table do
      row "ID" do
        td teacher.id
        th "姓名:"
        td teacher.name
      end
      row "编号:" do
        td teacher.number
        th "评分:"
        td teacher.score
      end
      row "身份:"  do
        case teacher.identity
        when Setting.teachers.identity_student
         td Setting.teachers.identity_student_string
        when Setting.teachers.identity_teacher
         td Setting.teachers.identity_teacher_string
        end
        th "状态:"
        case teacher.status
        when Setting.teachers.status_pass_sql
         td Setting.teachers.status_pass
        when Setting.teachers.status_notpass_sql
         td Setting.teachers.status_not_pass
        when Setting.teachers.status_edit_sql
          Setting.teachers.status_edit
        when Setting.teachers.status_none_sql
          Setting.teachers.status_none
        end
      end
      row "性别:" do
        case teacher.sex
        when Setting.teachers.sex_man
         td Setting.teachers.sex_man_string
        when Setting.teachers.sex_women
         td Setting.teachers.sex_women_string
        end
        th "年龄:"
        td teacher.age
      end
      if teacher.identity == 1 and teacher.student_identity
        row "学校:" do
          td teacher.student_identity.school
          th "活动:"
          td teacher.join_status
        end
        row "年级:" do
          td teacher.student_identity.grade
          th "专业:"
          td teacher.student_identity.major
        end
      else
        row "学校:" do
          td
        end
        row "年级:" do
          td
          th "专业:"
          td
        end
      end
      row "电话:" do 
        td  teacher.phone
        th "Email:"
        td teacher.email
      end
      row "支付宝:" do
        td teacher.pay_num
      end
      row "登录次数:" do 
        td teacher.sign_in_count
        th "最近登录时间:"
        td teacher.last_sign_in_at
      end
      row "创建时间:" do
        td teacher.created_at
        th "更新时间:"
        td teacher.updated_at
      end
      row "实际教龄:" do
        td teacher.teaching_age
        th "授课时期:"
        case teacher.period
        when Setting.courses.period_normal
         td Setting.courses.period_normal_string
        when Setting.courses.period_vacation
         td Setting.courses.period_vacation_string
        when Setting.courses.period_all
          Setting.courses.period_all_string
        end
      end
      row "教学理念:" do
        td teacher.quotes
      end
      row "教学科目:" do
        td teacher.my_categories
      end
      row "个人爱好:" do
        td teacher.hobby
      end
      row "个人经验:" do
        td teacher.introduction
      end
      row "过往经历:" do
        td teacher.experience
      end
      row "个人头像:" do
        td image_tag teacher.image.url,:width=>"90px" if !teacher.image.url.blank?
        th "身份证图片:"
        td image_tag teacher.paper_id_img.url,:width=>"90px" if !teacher.paper_id_img.blank?
      end
      row "学历证书:" do
        td image_tag teacher.paper_img.url ,:width=>"90px" if !teacher.paper_img.blank?
        th "教师证书:"
        td image_tag teacher.teacher_paper.url ,:width=>"90px" if !teacher.teacher_paper.blank?
      end
      row "专业资质证书:" do
        td image_tag teacher.professional_paper.url ,:width=>"90px" if !teacher.professional_paper.blank?
      end
      row "预约时间:" do
        td teacher.appointments.map{|a| "周"+a.weekday.to_s}.join", "
      end
      row "学习成绩:" do
        td teacher.scores.map{|a| a.title+":"+a.content}.join", "
      end
      row "所获荣誉:" do
        td teacher.honors.map{|a| a.title+":"+a.content}.join", "
      end
      row "荣誉图片:" do
        td teacher.pictures.map{|a| (image_tag a.honors_image, :width=>"90px")}
      end
      row "教学经历:" do
        td teacher.careers.map{|a| a.start_time.strftime("%Y-%m-%d")+"~"+a.end_time.strftime("%Y-%m-%d")+":"+a.child_name+":"+a.school+":"+a.subject+":"+a.content if a.start_time and a.end_time}.join", "
      end
      row "个人相册:" do
        td teacher.galleries.map{|a| (image_tag a.photo ,:width=>"90px")}
      end
      row "验证操作:" do
        td link_to(Setting.teachers.status_pass,teacherPass_admin_teacher_path(teacher.id)) + " " + link_to(Setting.teachers.status_not_pass,teacherNotPass_admin_teacher_path(teacher.id))
        th "活动操作:"
        td link_to("参加活动",teacherJoinActivity_admin_teacher_path(teacher.id)) + " " + link_to("不参加活动",teacherNotJoinActivity_admin_teacher_path(teacher.id))
      end
    end
  end

  #status 1-身份验证通过
  #status 0-身份验证拒绝
  #status 默认没有验证
  member_action :teacherPass do
    teacher=Teacher.find(params[:id])
    teacher.status = Setting.teachers.status_pass_sql
    teacher.save
    #teacher.update_attributes(:status=>Setting.teachers.status_pass_sql)
    message = Message.new(:title=>"恭喜您已经通过认证！", :content=>"亲爱的用户，非常高兴地通知您，您已经通过认证，快去发布课程吧，祝您找到满意的工作。遇到任何问题可以在客服QQ群（99183020）中交流。", :category=>Setting.messages.category_teacher, :status=>Setting.messages.status_unread)
    message.teacher = teacher
    message.save
    redirect_to :controller=>"teachers", :action=>"index"
  end

  member_action :teacherNotPass do
    teacher=Teacher.find(params[:id])
    teacher.status = Setting.teachers.status_notpass_sql
    teacher.save
    #teacher.update_attributes(:status=>Setting.teachers.status_notpass_sql)
    message = Message.new(:title=>"抱歉，您没有通过认证！", :content=>"亲爱的用户，您的信息不够完整哦，请您完善您的信息后再次提交认证，包括基本信息，学习成果，教学经历和教学计划等内容。遇到任何问题可以在客服QQ群（99183020）中交流。", :category=>Setting.messages.category_teacher, :status=>Setting.messages.status_unread)
    message.teacher = teacher
    message.save
    redirect_to :controller=>"teachers", :action=>"index"
  end

  member_action :teacherJoinActivity do
    teacher=Teacher.find(params[:id])
    teacher.join_status = Setting.teachers.join_status_sec_vote
    teacher.save
    redirect_to :controller=>"teachers", :action=>"index"
  end

  member_action :teacherNotJoinActivity do
    teacher=Teacher.find(params[:id])
    teacher.join_status = Setting.teachers.join_status_none
    teacher.save
    redirect_to :controller=>"teachers", :action=>"index"
  end

  sidebar "审核内容",except: :index do
    ul do
      li "身份证（×）"
      li "学历证（×）"
      li "教师资格证"
      li "专业资质证书"
      li "各个证书(姓名、身份证号码)是否一致"
      li "身份证、学历证书是必须选项"
      li "教师资格证、专业资格证是非必须选项"
      li "点击下方的按钮控制是否验证通过"
    end
  end

  controller do
    def scoped_collection
      if params[:order_teacher_id]
        super.where(:id=>params[:order_teacher_id])
      elsif params[:course_teacher_id]
        super.where(:id=>params[:course_teacher_id])
      elsif params[:message_teacher_id]
        super.where(:id=>params[:message_teacher_id])
      else
        super
      end
    end
  end

end
