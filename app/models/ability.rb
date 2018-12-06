# coding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)

    #user ||= User.new # guest user (not logged in)

    if user.is_a? AdminUser
      can :manage, :all

    elsif user.is_a? Parent
      #Order
      can :parent, Order do |order|
        order.parent_id == user.id
      end
      can :create, Order
      can :parent_pay, Order do |order|
        order.parent_id == user.id
      end

      #Comment
      can :new, Comment
      can :create, Comment

      #Parent
      can :profile, Parent
      can :modify_info, Parent
      can :modify_info_changed, Parent
      can :modify_password, Parent
      can :modify_password_changed, Parent
      can :order_all, Parent
      can :order_unpay, Parent
      can :order_reserving, Parent
      can :order_refund, Parent
      can :messages, Parent
      can :msg, Parent
      can :show_menu,Parent

    elsif user.is_a? Teacher
      #Course
      can :index, Course
      can :show, Course do |course|
        course.teacher_id == user.id
      end
      can :new, Course
      can :create, Course do |course|
        user.status == Setting.teachers.status_pass_sql
      end
      can :edit, Course do |course|
        course.teacher_id == user.id
      end
      can :update, Course do |course|
        course.teacher_id == user.id and user.status == Setting.teachers.status_pass_sql
      end
      can :destroy, Course do |course|
        course.teacher_id == user.id
      end
      can :select_second,Course
      can :select_third,Course

      #Order
      can :teacher, Order do |order|
        order.teacher_id == user.id
      end
      can :teacher_pay, Order do |order|
        order.teacher_id == user.id
      end

      #Teacher
      can :basicInfor, Teacher
      can :editInfor, Teacher
      can :editinfo_experience, Teacher
      can :editinfo_plan, Teacher
      can :editinfo_study, Teacher
      can :editinfo_basic, Teacher
      can :updateInfor, Teacher
      can :paper, Teacher
      can :upload, Teacher
      can :order_all, Teacher
      can :order_unpay, Teacher
      can :order_reserving, Teacher
      can :order_transfer, Teacher
      can :messages, Teacher
      can :msg, Teacher
      can :gallery,Teacher
      can :show_menu,Teacher
      can :sign_today,Teacher
    else

    end

  end
end
