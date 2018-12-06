# == Schema Information
#
# Table name: student_identities
#
#  id         :integer          not null, primary key
#  school     :string(255)
#  grade      :string(255)
#  major      :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StudentIdentity < ActiveRecord::Base
  belongs_to :teacher

  attr_accessible :school, :grade, :major

  validates :school,     :presence => true
  validates :grade,      :presence => true
  validates :major,      :presence => true

  validates :teacher_id,    :presence => true
end
