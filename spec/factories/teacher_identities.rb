# == Schema Information
#
# Table name: teacher_identities
#
#  id         :integer          not null, primary key
#  school     :string(255)
#  grade      :string(255)
#  subject    :string(255)
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher_identity do
  end
end
