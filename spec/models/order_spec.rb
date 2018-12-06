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

require 'spec_helper'

describe Order do
  it "is valid with something, address, appointment, parent, and line_items" do
    order       = create(:order)
    parent      = create(:parent)
    #order       = create(:order, :parent=>parent)
    address     = create(:address)
    appointment = create(:appointment_2)
    course      = create(:course)
    line_item   = create(:line_item, :course=>course)

    order.address     = address
    order.appointment = appointment
    order.parent      = parent
    order.line_items  << line_item
    order.save

    #有两种方式让parent.orders生效
    #(1)构造order时直接传入parent参数
    #(2)修改order属性后save

    expect(order).to be_valid
    expect(address.order).to eq(order)
    expect(appointment.order).to eq(order)
    expect(parent.orders).to include(order)
    expect(order.line_items[0].course).to eq(course)
    expect(line_item.order).to eq(order)
  end
end
