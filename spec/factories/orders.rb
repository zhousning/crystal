# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  phone             :string(255)
#  status            :integer          default(0), not null
#  parent_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  teacher_id        :integer
#  addr              :string(255)
#  appointments_time :datetime
#  hours             :integer          default(1)
#  total             :integer          default(1)
#  number            :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    name  "Samm"
    phone "13655556666"
  end
end
