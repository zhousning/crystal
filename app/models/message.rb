# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  category   :integer
#  status     :integer          default(1)
#  parent_id  :integer
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :parent
  belongs_to :teacher

  attr_accessible :category, :content, :status, :title
  attr_accessible :parent_id, :teacher_id
end
