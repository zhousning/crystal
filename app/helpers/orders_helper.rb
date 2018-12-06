# coding: utf-8

module OrdersHelper
  def get_order_status_string(status)
    if status == Setting.orders.status_none
      Setting.orders.status_none_string
    elsif status == Setting.orders.status_trade_created
      Setting.orders.status_trade_created_string
    elsif status == Setting.orders.status_parent_paied
      Setting.orders.status_parent_paied_string
    elsif status == Setting.orders.status_teacher_paied
      Setting.orders.status_teacher_paied_string
    elsif status == Setting.orders.status_trade_success
      Setting.orders.status_trade_success_string
    elsif status == Setting.orders.status_trade_failed
      Setting.orders.status_trade_failed_string
    end
  end

  def get_parent_order_button_string(status)
    if status == Setting.orders.status_trade_created
      "付款"
    else
      "查看"
    end
  end

  def get_teacher_order_button_string(status)
    "查看"
  end

  def get_parent_order_button_type(status)
    if status == Setting.orders.status_trade_created
      "btn-success"
    else
      "btn-info"
    end
  end

  def get_teacher_order_button_type(status)
    "btn-info"
  end

  def get_order_status
    status = [
      [Setting.orders.status_none_string,Setting.orders.status_none],
      [Setting.orders.status_trade_created_string,Setting.orders.status_trade_created],
      [Setting.orders.status_parent_paied_string,Setting.orders.status_parent_paied],
      [Setting.orders.status_teacher_paied_string,Setting.orders.status_teacher_paied],
      [Setting.orders.status_trade_success_string, Setting.orders.status_trade_success],
      [Setting.orders.status_trade_failed_string, Setting.orders.status_trade_failed]
    ]
  end

  def status_choice(status)
    if status == Setting.orders.status_none
      status_bar0
    elsif status == Setting.orders.status_trade_created
      status_bar1
    elsif status == Setting.orders.status_parent_paied
      status_bar2
    elsif status == Setting.orders.status_teacher_paied
      status_bar3
    elsif status == Setting.orders.status_trade_success
      status_bar7
    elsif status == Setting.orders.status_trade_failed
      status_bar8
    end
  end

  def status_bar0
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"提交订单",:class=>"order-progress-5-step order-progress-step-active")
    b=content_tag(:div,"支付订单",:class=>"order-progress-5-step")
    c=content_tag(:div,"家教确认",:class=>"order-progress-5-step")
    d=content_tag(:div,"上门试讲",:class=>"order-progress-5-step")
    e=content_tag(:div,"订单完成",:class=>"order-progress-5-step")
    a+z+b+c+d+e
  end

  def status_bar1
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"提交订单",:class=>"order-progress-5-step")
    b=content_tag(:div,"支付订单",:class=>"order-progress-5-step order-progress-step-active")
    c=content_tag(:div,"家教确认",:class=>"order-progress-5-step")
    d=content_tag(:div,"上门试讲",:class=>"order-progress-5-step")
    e=content_tag(:div,"订单完成",:class=>"order-progress-5-step")
    a+b+z+c+d+e
  end

  def status_bar2
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"提交订单",:class=>"order-progress-5-step")
    b=content_tag(:div,"支付订单",:class=>"order-progress-5-step")
    c=content_tag(:div,"家教确认",:class=>"order-progress-5-step order-progress-step-active")
    d=content_tag(:div,"上门试讲",:class=>"order-progress-5-step")
    e=content_tag(:div,"订单完成",:class=>"order-progress-5-step")
    a+b+c+z+d+e
  end

  def status_bar3
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"提交订单",:class=>"order-progress-5-step")
    b=content_tag(:div,"支付订单",:class=>"order-progress-5-step")
    c=content_tag(:div,"家教确认",:class=>"order-progress-5-step")
    d=content_tag(:div,"上门试讲",:class=>"order-progress-5-step order-progress-step-active")
    e=content_tag(:div,"订单完成",:class=>"order-progress-5-step")
    a+b+c+d+z+e
  end

  def status_bar7
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"提交订单",:class=>"order-progress-5-step")
    b=content_tag(:div,"支付订单",:class=>"order-progress-5-step")
    c=content_tag(:div,"家教确认",:class=>"order-progress-5-step")
    d=content_tag(:div,"上门试讲",:class=>"order-progress-5-step")
    e=content_tag(:div,"订单完成",:class=>"order-progress-5-step order-progress-step-active")
    a+b+c+d+e+z
  end

  def status_bar8
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"提交订单",:class=>"order-progress-5-step")
    b=content_tag(:div,"支付订单",:class=>"order-progress-5-step")
    c=content_tag(:div,"家教确认",:class=>"order-progress-5-step")
    d=content_tag(:div,"上门试讲",:class=>"order-progress-5-step")
    e=content_tag(:div,"退款完成",:class=>"order-progress-5-step order-progress-step-active")
    a+b+c+d+e+z
  end

  def tstatus_choice(status)
    if status == Setting.orders.status_parent_paied
      tstatus_bar2
    elsif status == Setting.orders.status_teacher_paied
      tstatus_bar3
    elsif status == Setting.orders.status_trade_success
      tstatus_bar7
    elsif status == Setting.orders.status_trade_failed
      tstatus_bar8
    end
  end

  def tstatus_bar2
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"确认订单",:class=>"order-progress-3-step order-progress-step-active")
    b=content_tag(:div,"上门试讲",:class=>"order-progress-3-step")
    c=content_tag(:div,"收到试讲费",:class=>"order-progress-3-step")
    a+z+b+c
  end

  def tstatus_bar3
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"确认订单",:class=>"order-progress-3-step")
    b=content_tag(:div,"上门试讲",:class=>"order-progress-3-step order-progress-step-active")
    c=content_tag(:div,"收到试讲费",:class=>"order-progress-3-step")
    a+b+z+c
  end

  def tstatus_bar7
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"确认订单",:class=>"order-progress-3-step")
    b=content_tag(:div,"上门试讲",:class=>"order-progress-3-step")
    c=content_tag(:div,"收到试讲费",:class=>"order-progress-3-step order-progress-step-active")
    a+b+c+z
  end

  def tstatus_bar8
    z=content_tag(:div,"",:class=>"order-progress-status order-progress-status-active")
    a=content_tag(:div,"确认订单",:class=>"order-progress-3-step")
    b=content_tag(:div,"上门试讲",:class=>"order-progress-3-step")
    c=content_tag(:div,"退款给家长",:class=>"order-progress-3-step order-progress-step-active")
    a+b+c+z
  end
end
