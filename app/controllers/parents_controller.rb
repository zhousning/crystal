# encoding: UTF-8

class ParentsController < ApplicationController
  before_filter :authenticate_parent!
  load_and_authorize_resource

  has_mobile_fu
  has_mobile_fu_for :profile,:modify_info,:order_all,:order_unpay,:order_reserving,:order_refund,:messages,:show_menu
  def profile
    @address = Address.find_by_parent_id(current_parent.id)
    @orders = current_parent.orders.find(:all,:conditions => {:status => Setting.orders.status_trade_created},:order => "created_at desc")
  end
  
  def modify_info
    @parent = current_parent
    @address = current_parent.address
  end
  
  def modify_info_changed
    @parent = current_parent
    @address = current_parent.address
    if @address
      @address.update_attributes(params[:address])
    else
      @address = Address.new(params[:address])
      @address.parent = current_parent
      @address.save
      #允许不修改地址
      #unless @address.save
      #  flash.now[:error] = t('parents.modify_info_changed.error')
      #  render action: "modify_info" and return
      #end
    end

    if @parent.update_attributes(params[:parent])
      flash.now[:success] = t('parents.modify_info_changed.success')
      redirect_to profile_parents_url
    else
      flash.now[:error] = t('parents.modify_info_changed.error')
      render action: "modify_info" 
    end
  end

  def modify_password
    @parent = current_parent    
  end
  
  def modify_password_changed
    @parent = current_parent  
    respond_to do |format|  
      print "parent: #{params[:parent]}"  
     # if params[:parent]["password"] == @parent.password
        if params[:parent]["password"] == params[:parent]["password_confirmation"]  
          if @parent.update_attributes(params[:parent])  
            flash.now[:notice] = 'Parent was successfully updated.'  
            format.html { redirect_to "/login" }  
          else 
            flash.now[:notice] = 'Password was fail updated.'
            format.html { redirect_to :back }  
          end  
        else  
          flash.now[:notice] = 'Password and Password confirm are not the same'  
          format.html { redirect_to :back }  
        end  
      #else
      #  flash.now[:notice] = 'Password is not the old password.'
       # format.html{ redirect_to :back}
     # end
    end  
  end

  def order_all
    @orders = current_parent.orders.find(:all,:order => "created_at desc")
  end

  def order_unpay
    @orders = current_parent.orders.find(:all,:conditions => {:status => Setting.orders.status_trade_created},:order => "created_at desc")
  end

  def order_reserving
    @orders = current_parent.orders.find(:all,:conditions => {:status => [Setting.orders.status_parent_paied, Setting.orders.status_teacher_paied]},:order => "created_at desc")
  end

  def order_refund
    @orders = current_parent.orders.find(:all,:conditions => {:status => Setting.orders.status_trade_failed},:order => "created_at desc")
  end

  def messages
    @messages = Message.where("parent_id = #{current_parent.id} and category = #{Setting.messages.category_parent} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
    @group_messages = Message.where("category = #{Setting.messages.category_parent_public} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
    @public_messages = Message.where("category = #{Setting.messages.category_public} and status in (#{Setting.messages.status_unread}, #{Setting.messages.status_read})")
  end
  
  def msg
    @message = Message.find(params[:message])
    @message.update_attribute :status, Setting.messages.status_read
  end

  def show_menu
  end
end
