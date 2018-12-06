# == Schema Information
#
# Table name: pictures
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  honors_image :string(255)
#  teacher_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Picture < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :honors_image, :title, :remove_honors_image
  mount_uploader :honors_image, PaperUploader
end
