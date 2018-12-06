# == Schema Information
#
# Table name: information
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  content          :text
#  img              :string(255)
#  name             :string(255)
#  phone            :string(255)
#  qq               :string(255)
#  weixin           :string(255)
#  number           :string(255)
#  info_category_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  click_times      :integer          default(0)
#  qrcode           :string(255)
#  qrcode_uid       :string(255)
#

class Information < ActiveRecord::Base
  attr_accessible :content, :img,  :name, :phone, :qq, :title, :weixin,:info_category_id,:click_times,:number,:qrcode_uid

  belongs_to :info_category

  #before_save :store_unique_number
  #def store_unique_number
  #  unless self.number
  #    self.number = (rand(1..9)*10000000 + rand(10000000)).to_s
  #  end
  #end

  validates :content,    :presence => true
  validates :title,    :presence => true
  validates :name,    :presence => true
  validates :phone,     :presence => true,
                        :numericality => {:only_integer => true}
  validates_length_of :title, :in => 3..20
  mount_uploader :img, PaperUploader
  dragonfly_accessor :qrcode do
    after_assign { |img| img.encode!('png') }
  end
end
