# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  weekday    :integer
#  time       :integer
#  course_id  :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#  teacher_id :integer
#

class Appointment < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :order

  attr_accessible :weekday, :time, :position

#  validates :weekday,   :presence => true,
#                        :numericality => {:only_integer => true}
#  validates :time,      :presence => true,
#                        :numericality => {:only_integer => true}
end
