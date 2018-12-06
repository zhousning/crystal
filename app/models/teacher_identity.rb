# == Schema Information
#
# Table name: teacher_identities
#
#  id         :integer          not null, primary key
#  school     :string(255)
#  grade      :string(255)
#  subject    :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeacherIdentity < ActiveRecord::Base
  belongs_to :teacher

  attr_accessible :school, :grade, :subject

  validates :school,     :presence => true
  validates :grade,      :presence => true
  validates :subject,    :presence => true

  validates :teacher_id,    :presence => true
end
