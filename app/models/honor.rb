# == Schema Information
#
# Table name: honors
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Honor < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :content, :title
end
