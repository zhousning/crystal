# coding: utf-8
#
# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  phone             :string(255)
#  status            :integer          default(0), not null
#  parent_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  teacher_id        :integer
#  addr              :string(255)
#  appointments_time :datetime
#  hours             :integer          default(1)
#  total             :integer          default(1)
#  number            :string(255)
#

class Order < ActiveRecord::Base
  has_many :line_items
  has_many :courses, :through => :line_items
  has_many :trades
  has_many :order_traces
  has_one  :address
  has_one  :appointment
  belongs_to :parent
  belongs_to :teacher
  
  accepts_nested_attributes_for :address

  attr_accessible :name, :phone, :addr, :appointments_time, :hours, :total

  validates :name,       :presence => true
  validates :phone,      :presence => true
  validates :addr,       :presence => true
  validates :appointments_time, :presence => true
  validates :status,     :presence => true,
                         :numericality => {:only_integer => true}

  validates :parent_id,     :presence => true
  validates :teacher_id,    :presence => true

  before_save :store_unique_number
  def store_unique_number
    unless self.number
      self.number = "1001" + Time.now.strftime("%Y%m%d") + "%04d" % [rand(10000)]
    end
  end

  after_save :add_trace_after_status_changed
  def add_trace_after_status_changed
    if self.status_changed?
      if self.status == Setting.orders.status_trade_created
        OrderTrace.create(:p_content=>"您提交了订单", :p_operator=>"您", :t_content=>"家长提交了订单", :t_operator=>"家长", :status=>self.status, :order_id=>self.id)
      elsif self.status == Setting.orders.status_parent_paied
        OrderTrace.create(:p_content=>"您支付了订单", :p_operator=>"您", :t_content=>"家长支付了订单", :t_operator=>"家长", :status=>self.status, :order_id=>self.id)
      elsif self.status == Setting.orders.status_teacher_paied
        OrderTrace.create(:p_content=>"家教确认了您的订单", :p_operator=>"家教", :t_content=>"您确认了家长的订单", :t_operator=>"您", :status=>self.status, :order_id=>self.id)
      elsif self.status == Setting.orders.status_trade_success
        OrderTrace.create(:p_content=>"试讲费用已打入家教的支付宝中", :p_operator=>"系统", :t_content=>"试讲费用已打入您的支付宝中", :t_operator=>"系统", :status=>self.status, :order_id=>self.id)
      elsif self.status == Setting.orders.status_trade_failed
        OrderTrace.create(:p_content=>"试讲费用已退回到您的支付宝中", :p_operator=>"系统", :t_content=>"试讲费用已退回到家长的支付宝中", :t_operator=>"系统", :status=>self.status, :order_id=>self.id)
      end
    end
  end
end
