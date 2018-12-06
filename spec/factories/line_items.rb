# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tradecode  :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
  end
end
