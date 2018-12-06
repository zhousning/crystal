# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  total      :integer
#  desc       :integer
#  attitude   :integer
#  speed      :integer
#  content    :string(255)
#  category   :integer
#  teacher_id :integer
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :parent

  attr_accessible :total, :desc, :attitude, :speed, :content, :category

  validates :total,      :presence => true
  validates :desc,       :presence => true
  validates :attitude,   :presence => true
  validates :speed,      :presence => true
  validates :content,    :presence => true
  validates :category,   :presence => true,
                         :numericality => {:only_integer => true}

  validates :teacher_id,  :presence => true
  validates :parent_id,   :presence => true
end
