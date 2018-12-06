# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Score < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :content, :title
end
