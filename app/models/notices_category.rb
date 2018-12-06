# == Schema Information
#
# Table name: notices_categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NoticesCategory < ActiveRecord::Base
  attr_accessible :title

  has_many :notices
end
