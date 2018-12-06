# encoding: UTF-8

require 'rmagick'
require 'chunky_png/rmagick'

class TeachersController < ApplicationController
  layout "application_blank", :only => [:sign_up, :login]
  before_filter :authenticate_teacher!, :except => [:detail]
  load_and_authorize_resource :except => [:detail]
  has_mobile_fu
  has_mobile_fu_for :detail,:editinfo_basic,:show_menu,:editinfo_plan,:gallery,:messages,:order_all,:order_unpay,:order_reserving,:order_transfer,:basicInfor,:editinfo_study,:editinfo_experience

  def basicInfor
    @orders = current_teacher.orders.find(:all,:conditions => {:status => Setting.orders.status_parent_paied},:order => "created_at desc")

    basicInfo_judge
    study_judge
    experience_judge
    plan_judge
  end

  def editinfo_experience
    editInfor
  end

  def editinfo_plan
    editInfor
  end

  def editinfo_study
    editInfor
  end

  def editinfo_basic
    editInfor
  end

  def editInfor
    if current_teacher.scores.length == 0
      current_teacher.scores.build
    end
    if current_teacher.honors.length == 0
      current_teacher.honors.build
    end
    if current_teacher.pictures.length == 0
      current_teacher.pictures.build
    end
    if current_teacher.careers.length == 0
      current_teacher.careers.build
    end

    @appointments_pos =[]
    current_teacher.appointments.each do |appointment|
      @appointments_pos << appointment.weekday
    end 
  end


  def updateInfor
    current_teacher.status = Setting.teachers.status_edit_sql

    if params[:info]
      current_teacher.status = Setting.teachers.status_edit_sql
    end

    if params[:remove_honors_image]
      params[:remove_honors_image].each do |r|
        current_teacher.pictures[r.to_i].remove_honors_image!
      end
        Picture.delete_all(:honors_image=>nil)
    end

    identity=current_teacher.identity
    if identity==Setting.teachers.identity_student
      if current_teacher.student_identity
        current_teacher.student_identity.update_attributes(params[:student_identity])
      else
        current_teacher.create_student_identity(params[:student_identity]) 
      end
    elsif identity==Setting.teachers.identity_teacher
      if current_teacher.teacher_identity
        current_teacher.teacher_identity.update_attributes(params[:teacher_identity])
      else
        current_teacher.create_teacher_identity(params[:teacher_identity]) 
      end
    end

    #TODO: 没有选择预约时间时给出错误提示, 需要通过validate来实现
    #TODO: 当update_attributes失败时，会保存一些没有关联的appointment到数据库
    @appointments_pos = params[:appointments_pos]
    if @appointments_pos
      Appointment.delete_all(:teacher_id=>current_teacher.id)
      @appointments_pos = @appointments_pos.map {|p| p.to_i}
      @appointments_pos.each do |pos|
        @appointment = Appointment.new(:weekday=>pos)
        #@appointment.time = pos / 7 + 1
        #@appointment.weekday = pos % 7 + 1
        @appointment.teacher = current_teacher
        @appointment.save
      end
    end

    if current_teacher.update_attributes(params[:teacher])
      flash.now[:success] = t('teachers.editInfor.success')
      redirect_to basicInfor_teachers_url
    else
      flash.now[:error] = t('teachers.editInfor.error')
      @appointments_pos = []
      render action: "editinfo_basic"
    end
  end

  def paper
  end

  def upload
    item_img=params[:item_img]
    if item_img==Setting.teachers.item_img_basic.to_s
      current_teacher.status = Setting.teachers.status_edit_sql
    end
    if params[:galleries]
      @gallery=Gallery.new(params[:galleries])
      @gallery.teacher=current_teacher
      @gallery.save
    end
    if current_teacher.update_attributes(params[:teacher])
      flash.now[:success] = t('teachers.upload.success')
    else
      flash.now[:error] = t('teachers.upload.error')
    end
    if item_img==Setting.teachers.item_img_paper.to_s
      redirect_to paper_teachers_url
    elsif item_img==Setting.teachers.item_img_basic.to_s
      redirect_to editInfor_teachers_url
    elsif item_img==Setting.teachers.item_img_gallery.to_s
      redirect_to gallery_teachers_url
    end
    if params[:remove_galleries_image]
      params[:remove_galleries_image].each do |r|
        current_teacher.galleries[r.to_i].remove_photo!
      end
      Gallery.delete_all(:photo=>nil)
    end

  end

  def order_all
    @orders = current_teacher.orders.find(:all,:order => "created_at desc")
    @orders = @orders.select {|o| [Setting.orders.status_parent_paied, Setting.orders.status_teacher_paied, Setting.orders.status_trade_success, Setting.orders.status_trade_failed].include?(o.status)}
  end

  def order_unpay
    @orders = current_teacher.orders.find(:all,:conditions => {:status => Setting.orders.status_parent_paied},:order => "created_at desc")
  end

  def order_reserving
    @orders = current_teacher.orders.find(:all,:conditions => {:status => Setting.orders.status_teacher_paied},:order => "created_at desc")
  end

  def order_transfer
    @orders = current_teacher.orders.find(:all,:conditions => {:status => Setting.orders.status_trade_success},:order => "created_at desc")
  end

  def messages
    @messages = Message.where("teacher_id = #{current_teacher.id} and category = #{Setting.messages.category_teacher} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
    @group_messages = Message.where("category = #{Setting.messages.category_teacher_public} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
    @public_messages = Message.where("category = #{Setting.messages.category_public} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
  end
  
  def msg
    @message = Message.find(params[:message])
    @message.update_attribute :status, Setting.messages.status_read
  end

  def detail
    @teacher = Teacher.find_by_number(params[:id])
    @course_json = @teacher.courses.to_json
    @careers = @teacher.careers.order("start_time DESC")
    @appointments = @teacher.appointments.map {|a| a.weekday}
    @active_dates = []
    (1..31).each do |step|
      if @appointments.include? (Time.now + step.days).wday
        @active_dates << (Time.now + step.days).strftime("%-d/%-m/%Y")
      end
    end
    gon.active_dates = @active_dates
    @parent = Parent.new

    @comments = @teacher.comments
    @good_num = 0;
    @medium_num = 0;
    @bad_num = 0;
    @comments.each do |comment|
      if comment.total == Setting.comments.total_good
        @good_num += 1
      elsif comment.total == Setting.comments.total_medium
        @medium_num += 1
      else
        @bad_num += 1
      end
    end
  end

  def gallery
    if current_teacher.galleries.length == 0
      current_teacher.galleries.build
    end
  end

  def sign_today
    current_date = Time.now.strftime("%Y%m%d")
    if current_teacher.signdate.last != current_date
      if current_teacher.signdate.last == (Time.now-1.day).strftime("%Y%m%d")
        current_teacher.signcount += 1
      else
        current_teacher.signcount = 1
      end
      current_teacher.signdate << current_date
      current_teacher.save
    end
    redirect_to basicInfor_teachers_url
  end
  
  private
  def basicInfo_judge
    if current_teacher.name.blank? || current_teacher.age.blank? || current_teacher.sex.blank? || current_teacher.hobby.blank? || current_teacher.introduction.blank? ||current_teacher.paper_img.blank? || current_teacher.image.blank? || current_teacher.teaching_age.blank?
      @basic_degree = 0  
    end
    
    identity=current_teacher.identity
    if identity==Setting.teachers.identity_student
      if current_teacher.student_identity.nil? || current_teacher.student_identity.school.blank? ||  current_teacher.student_identity.school.blank? || current_teacher.student_identity.school.blank? 
        @basic_degree = 0
      end
    elsif identity==Setting.teachers.identity_teacher
      if current_teacher.teacher_identity.nil? || current_teacher.teacher_identity.school.blank? ||  current_teacher.teacher_identity.grade.blank? || current_teacher.teacher_identity.subject.blank? 
        @basic_degree = 0
      end
    end
  end

  def study_judge
    if current_teacher.scores.blank? || current_teacher.pictures.blank? || current_teacher.honors.blank?
      @study_degree = 0
    end
  end

  def experience_judge
    if current_teacher.careers.blank?
      @experience_degree = 0
    end
  end

  def plan_judge
    if current_teacher.appointments.blank? 
      @plan_degree = 0
    end
  end

  def show_menu
  end

  def download
    @teacher = Teacher.find_by_number(params[:id])
    data = open(File.join(Rails.root, 'public', 'pictures', @Teacher.qrcode_uid))
    send_data data.read, :filename=>"#{@teacher.name}.png", :type => "application/force-download", :x_sendfile=>true
  end
end
