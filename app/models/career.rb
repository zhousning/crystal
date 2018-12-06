# == Schema Information
#
# Table name: careers
#
#  id           :integer          not null, primary key
#  start_time   :datetime
#  end_time     :datetime
#  child_name   :string(255)
#  school       :string(255)
#  subject      :string(255)
#  before_score :string(255)
#  after_score  :string(255)
#  content      :text
#  teacher_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Career < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :after_score, :before_score, :child_name, :content, :end_time, :school, :start_time, :subject
end
