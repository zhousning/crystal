# == Schema Information
#
# Table name: notices
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  content             :text
#  category            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  notices_category_id :integer
#  number              :string(255)
#

class Notice < ActiveRecord::Base
  attr_accessible :category, :content, :title, :notices_category_id
  belongs_to :notices_category

  before_save :store_unique_number
  def store_unique_number
    unless self.number
      self.number = (rand(1..9)*10000000 + rand(10000000)).to_s
    end
  end
end
