# coding: utf-8
#
# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  second     :string(255)
#  third      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  number     :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    subject "数学"
    second  "高中"
    third   "一年级"
  end
end
