# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  province   :string(255)
#  city       :string(255)
#  district   :string(255)
#  teacher_id :integer
#  parent_id  :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  details    :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    province    "Jilin"
    city        "Jilin"
    district    "Chuanying"
    #association :teacher
  end
end
