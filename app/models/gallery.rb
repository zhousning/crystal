# == Schema Information
#
# Table name: galleries
#
#  id         :integer          not null, primary key
#  photo      :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Gallery < ActiveRecord::Base
  belongs_to :teacher
  mount_uploader :photo, PaperUploader
  attr_accessible :photo, :teacher_id
end
