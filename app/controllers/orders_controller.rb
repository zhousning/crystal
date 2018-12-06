# encoding: UTF-8

class OrdersController < ApplicationController
  #这条语句不生效
  #before_filter {:authenticate_parent! or :authenticate_teacher!}
  load_and_authorize_resource :find_by => :number
  has_mobile_fu
  has_mobile_fu_for :new, :parent, :teacher, :parent_pay, :teacher_pay

  def new
    @order = Order.new
    @address = Address.find_by_parent_id(current_parent.id) if current_parent
    @course = Course.find(params[:course][:id])

    @appointments = @course.teacher.appointments.map {|a| a.weekday}
    @active_dates = []
    (1..31).each do |step|
      if @appointments.include? (Time.now + step.days).wday
        @active_dates << (Time.now + step.days).strftime("%-d/%-m/%Y")
      end
    end
    gon.active_dates = @active_dates

    @day = [0,1,2,3,4,5,6]
    gon.inactive_dates = @day - @appointments
  end

  def create
    #防止非法输入
    if params[:order][:hours].to_i <= 0
      flash.now[:error] = t('orders.create.error')
      redirect_to new_order_url("course[id]"=>params[:course_id]) and return
    end
    @course = Course.find(params[:course_id])
    @line_item = LineItem.new
    @line_item.course = @course
    @line_item.tradecode = (rand(1..9)*10000000 + rand(10000000)).to_s
    @line_item.save

    @order = Order.new(params[:order])
    @order.line_items << @line_item
    @order.parent = current_parent
    @order.teacher = @course.teacher
    @order.total = @order.hours * @course.price.to_i

    @parent_trade = Trade.new
    @parent_trade.category = Setting.trades.category_parent
    @parent_trade.price = @order.total
    @parent_trade.subject = "预约课程《#{@course.name}》家教：#{@course.teacher.name}"
    @parent_trade.save

    @teacher_trade = Trade.new
    @teacher_trade.category = Setting.trades.category_teacher
    @teacher_trade.price = Setting.trades.price_teacher_pay
    @teacher_trade.subject = "预约课程《#{@course.name}》接受预约"
    @teacher_trade.save
   
    @order.trades << @parent_trade
    @order.trades << @teacher_trade
    @order.status = Setting.orders.status_trade_created
    
    if @order.save
      flash.now[:success] = t('orders.create.success')
      redirect_to parent_orders_url(:id=>@order.number)
    else
      flash.now[:error] = t('orders.create.error')
      redirect_to new_order_url("course[id]"=>params[:course_id])
    end
  end

  def parent
    @order = Order.find_by_number(params[:id])
    @course = Course.find(@order.courses[0].id)

    @appointments_pos = []
    @appointments_pos << @order.appointments_time
  end

  def teacher
    @order = Order.find_by_number(params[:id])
    @course = Course.find(@order.courses[0].id)
  end

  def parent_pay
    @order = Order.find_by_number(params[:id])
    @trade = @order.trades[0]
    # TODO: Open a new window to visit alipay.
    if is_mobile_device?
      redirect_to @trade.wap_pay_url
    else
      redirect_to @trade.pay_url
    end
  end

  def teacher_pay
    @order = Order.find_by_number(params[:id])
    if @order.status == Setting.orders.status_parent_paied
      @order.update_attribute :status, Setting.orders.status_teacher_paied
    end
    redirect_to teacher_orders_url(:id=>@order.number)
  end
end
