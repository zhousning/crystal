# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  second     :string(255)
#  third      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  number     :integer
#

class Category < ActiveRecord::Base
  has_many :courses

  attr_accessible :subject, :second, :third, :number

  validates :subject,    :presence => true
  validates :second,     :presence => true
  validates :third,      :presence => true
end
