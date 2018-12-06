# == Schema Information
#
# Table name: info_categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InfoCategory < ActiveRecord::Base
  attr_accessible :title

  has_many :information

end
