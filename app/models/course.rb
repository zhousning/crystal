# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  experence   :integer
#  mode        :string(255)
#  length      :integer
#  price       :string(255)
#  status      :integer          default(0)
#  category_id :integer
#  teacher_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  period      :integer          default(0)
#

class Course < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items
  belongs_to :teacher
  belongs_to :category
  
  accepts_nested_attributes_for :category
  attr_accessible :name, :mode, :length, :price

  validates :name,       :presence => true
  validates :mode,       :presence => true
  
  #validates :length,     :presence => true,
  #                       :numericality => {:only_integer => true}
  validates :price,      :presence => true
  validates :status,     :presence => true,
                         :numericality => {:only_integer => true}

  validates :category_id,   :presence => true
  validates :teacher_id,    :presence => true
end
