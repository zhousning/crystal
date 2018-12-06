# == Schema Information
#
# Table name: student_identities
#
#  id         :integer          not null, primary key
#  school     :string(255)
#  grade      :string(255)
#  major      :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_identity do
    school      "Tsinghua"
    grade       "One"
    major       "Computing Science"
    #association :teacher
  end
end
