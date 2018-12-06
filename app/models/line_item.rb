# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tradecode  :string(255)
#

class LineItem < ActiveRecord::Base
  belongs_to :course
  belongs_to :order

  validates :course_id,   :presence => true
  #validates :order_id,    :presence => true
end
