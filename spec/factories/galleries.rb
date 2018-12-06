# == Schema Information
#
# Table name: galleries
#
#  id         :integer          not null, primary key
#  photo      :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gallery do
    photo "MyString"
    teacher_id 1
  end
end
