# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  province   :string(255)
#  city       :string(255)
#  district   :string(255)
#  teacher_id :integer
#  parent_id  :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  details    :string(255)
#

class Address < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :parent
  belongs_to :order

  attr_accessible :province, :city, :district, :details

  validates :province,   :presence => true
  validates :city,       :presence => true
  validates :district,   :presence => true
  #validates :details,    :presence => true
end
