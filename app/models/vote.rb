# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  ip         :string(255)
#  sign       :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  session    :string(255)
#  sign2      :string(255)
#

class Vote < ActiveRecord::Base
  belongs_to :teacher

  attr_accessible :ip, :sign, :sign2, :session

  validates :ip,            :presence => true
  validates :sign,          :presence => true,
                            :uniqueness => {:case_sensitive => false}
  validates :sign2,         :presence => true,
                            :uniqueness => {:case_sensitive => false}
  validates :session,       :presence => true
  validates :teacher_id,    :presence => true
end
