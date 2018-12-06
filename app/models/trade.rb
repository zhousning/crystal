# coding: utf-8
#
# == Schema Information
#
# Table name: trades
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  category   :string(255)
#  price      :integer          default(1), not null
#  quantity   :integer          default(1), not null
#  discount   :integer
#  subject    :string(255)
#  trade_no   :string(255)
#  state      :string(255)      default("opening"), not null
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trade < ActiveRecord::Base
  belongs_to :order

  #attr_accessible :price, :quantity, :discount

  validates :category,   :presence => true
  validates :price,      :presence => true,
                         :numericality => {:only_integer => true}
  validates :subject,    :presence => true

  #validates :order_id,   :presence => true

  STATE = %w(opening pending paid completed canceled)
  validates_inclusion_of :state, :in => STATE

  STATE.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  before_save :store_unique_number
  def store_unique_number
    unless self.number
      self.number = Time.now.strftime("%Y%m%d") + "%04d" % [rand(10000)]
    end
  end

  def pend
    if opening?
      update_attribute :state, 'pending'
    end
  end

  def pay
    if pending?
      add_plan
      update_attribute :state, 'paid'
    end
  end

  def complete
    if pending? or paid?
      add_plan if pending?
      update_attribute :state, 'completed'
    end
  end

  def cancel
    if pending? or paid?
      remove_plan if paid?
      update_attribute :state, 'canceled'
    end
  end

  def pay_url
    #Alipay::Service.trade_create_by_buyer_url(
    Alipay::Service.create_direct_pay_by_user_url(
      :out_trade_no      => number,
      :price             => price,
      :quantity          => quantity,
      #:discount          => discount,
      :subject           => subject,
      :logistics_type    => 'DIRECT',
      :logistics_fee     => '0',
      :logistics_payment => 'SELLER_PAY',
      :return_url        => Rails.application.routes.url_helpers.trade_url(self, :host => 'www.jiajiaone.com'),
      :notify_url        => Rails.application.routes.url_helpers.alipay_notify_trades_url(:host => 'www.jiajiaone.com')
      #:receive_name      => 'none',
      #:receive_address   => 'none',
      #:receive_zip       => '100000',
      #:receive_mobile    => '100000000000'
    )
  end

  def wap_pay_url
    token = Alipay::Wap::Service.trade_create_direct_token(
      req_data: {
        :seller_account_name => 'jilinmei@gmail.com',
        :out_trade_no        => number,
        :subject             => subject,
        :total_fee           => price.to_s,
        :call_back_url       => Rails.application.routes.url_helpers.trade_url(self, :host => 'www.jiajiaone.com'),
        :notify_url          => Rails.application.routes.url_helpers.alipay_notify_trades_url(:host => 'www.jiajiaone.com')
      }
    )
    Alipay::Wap::Service.auth_and_execute_url(request_token: token)
  end

  def send_good
    Alipay::Service.send_goods_confirm_by_platform(
      :trade_no => trade_no,
      :logistics_name => 'www.jiajiaone.com',
      :transport_type => 'DIRECT'
    )
  end

  def add_plan
    if category == Setting.trades.category_parent
      if self.order.status == Setting.orders.status_trade_created
        self.order.update_attribute :status, Setting.orders.status_parent_paied
      end
    end
    #if category == Setting.trades.category_teacher
    #  if self.order.status == Setting.orders.status_parent_paied
    #    self.order.update_attribute :status, Setting.orders.status_teacher_paied
    #  end
    #end
  end

  def remove_plan
  end
end
