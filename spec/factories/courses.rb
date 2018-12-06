# coding: utf-8
#
# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  experence   :integer
#  mode        :string(255)
#  length      :integer
#  price       :string(255)
#  status      :integer          default(0)
#  category_id :integer
#  teacher_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  period      :integer          default(0)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name      "高考状元家教高一数学"
    experence 1
    mode      "一对一"
    length    60
    price     "50-100元/小时"
  end
end
