# encoding: UTF-8

class HomeController < ApplicationController
  layout "application_blank", :only => [:sign_up, :login]
  has_mobile_fu
  has_mobile_fu_for :login, :index

  def index
    ##个人信息只显示未读的, 其他信息已读和未读都显示
    #@messages = []
    #@group_messages = []
    #@public_messages = Message.where("category = #{Setting.messages.category_public} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
    #if parent_signed_in?
    #  @messages = Message.where("parent_id = #{current_parent.id} and category = #{Setting.messages.category_parent} and status = #{Setting.messages.status_unread}").order("id desc")
    #  @group_messages = Message.where("category = #{Setting.messages.category_parent_public} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
    #elsif teacher_signed_in?
    #  @messages = Message.where("teacher_id = #{current_teacher.id} and category = #{Setting.messages.category_teacher} and status = #{Setting.messages.status_unread}").order("id desc")
    #  @group_messages = Message.where("category = #{Setting.messages.category_teacher_public} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
    #end

    #@notices = Notice.limit(6).order("created_at desc")

    #if parent_signed_in?
    #  @num_dzf = 0
    #  @num_dsk = 0
    #  @orders = current_parent.orders
    #  @orders.each do |o|
    #    if o.status == Setting.orders.status_trade_created
    #      @num_dzf = @num_dzf + 1 
    #    elsif o.status == Setting.orders.status_teacher_paied
    #      @num_dsk = @num_dsk + 1 
    #    end
    #  end
    #elsif teacher_signed_in?
    #  @num_dqr = 0
    #  @num_dsk = 0
    #  @orders = current_teacher.orders
    #  @orders.each do |o|
    #    if o.status == Setting.orders.status_parent_paied
    #      @num_dqr = @num_dqr + 1 
    #    elsif o.status == Setting.orders.status_teacher_paied
    #      @num_dsk = @num_dsk + 1 
    #    end
    #  end
    #end

    @new_teachers = Teacher.where(:status => Setting.teachers.status_pass_sql).order("updated_at desc").limit(10)
    @normal_teachers = Teacher.where(:status => Setting.teachers.status_pass_sql).order("score desc").limit(100)
    @count = 0
    @courses = Course.where(:category_id => Category.where("second = '计算机'").select("id")).limit(100).group("teacher_id").order("created_at desc")
    @profess_teachers = @courses.map {|course| course.teacher if course.teacher}
    @profess_teachers.uniq!{|t| t.id}
    @profess_teachers.sort!{|a,b| b.score<=>a.score}
    @profess_teachers.reject!{|t| t.status != Setting.teachers.status_pass_sql}
    @profess_teachers = @profess_teachers[0..4]
  end
  
  def login
    @parent= Parent.new
    @teacher = Teacher.new
  end

  def sign_up
  end

  def flow
  end

  def tflow
  end

end
