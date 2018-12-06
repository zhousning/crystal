# encoding: UTF-8

class TradesController < ApplicationController
  def show
    @trade = Trade.find(params[:id])

    callback_params = params.except(*request.path_parameters.keys)
    if callback_params.any? && Alipay::Sign.verify?(callback_params)
      #if @trade.paid? || @trade.completed?
      #  flash.now[:success] = I18n.t('order_paid_message')
      #elsif @trade.pending?
      #  flash.now[:info] = I18n.t('order_pending_message')
      #end
    end

    if @trade.category == Setting.trades.category_parent
      flash.now[:success] = t('trades.show.parent_success')
      redirect_to parent_orders_url(:id=>@trade.order.number)
    #else
    #  flash.now[:success] = t('trades.show.teacher_success')
    #  redirect_to teacher_orders_url(:id=>@trade.order.number)
    end
  end

  def alipay_notify
    notify_params = params.except(*request.path_parameters.keys)
    if Alipay::Sign.verify?(notify_params) and Alipay::Notify.verify?(notify_params)
      @trade = Trade.find_by_number(params[:out_trade_no])

      case params[:trade_status]
      #when 'WAIT_BUYER_PAY'  #Aliapy不触发这个消息的通知
      #  @trade.update_attribute :trade_no, params[:trade_no]
      #  @trade.pend
      when 'TRADE_SUCCESS'
        @trade.update_attribute :trade_no, params[:trade_no]
        @trade.pend
        @trade.complete
      when 'TRADE_FINISHED'
        @trade.update_attribute :trade_no, params[:trade_no]
        @trade.pend
        @trade.complete
      #when 'TRADE_CLOSED'  #Alipay不触发这个消息的通知
      #  @trade.cancel
      end

      render :text => 'success'
    elsif Alipay::Wap::Notify.verify?(notify_params)
      notify_data = Hash.from_xml(params[:notify_data])["notify"]

      @trade = Trade.find_by_number(notify_data["out_trade_no"])

      case notify_data["trade_status"]
      #when 'WAIT_BUYER_PAY'  #Aliapy不触发这个消息的通知
      #  @trade.update_attribute :trade_no, notify_data["trade_no"]
      #  @trade.pend
      when 'TRADE_SUCCESS'
        @trade.update_attribute :trade_no, notify_data["trade_no"]
        @trade.pend
        @trade.complete
      when 'TRADE_FINISHED'
        @trade.update_attribute :trade_no, notify_data["trade_no"]
        @trade.pend
        @trade.complete
      #when 'TRADE_CLOSED'  #Alipay不触发这个消息的通知
      #  @trade.cancel
      end

      render :text => 'success'
    else
      render :text => 'error'
    end
  end
end
