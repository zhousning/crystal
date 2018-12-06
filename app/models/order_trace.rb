# == Schema Information
#
# Table name: order_traces
#
#  id         :integer          not null, primary key
#  p_content  :string(255)
#  t_content  :string(255)
#  p_operator :string(255)
#  t_operator :string(255)
#  status     :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderTrace < ActiveRecord::Base
  belongs_to :order

  attr_accessible :p_content, :t_content, :p_operator, :t_operator
  attr_accessible :status, :order_id
end
