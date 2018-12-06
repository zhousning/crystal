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

require 'spec_helper'

describe Course do
  it "is valid with something, category and appointments" do
    category     = create(:category)
    course       = create(:course, :category=>category)
    appointment1 = create(:appointment_1)
    appointment2 = create(:appointment_2)
    appointment3 = create(:appointment_3)
    course.appointments << appointment1
    course.appointments << appointment2
    course.appointments << appointment3

    expect(course).to be_valid
    expect(course.category).to eq(category)
    expect(category.courses).to include(course)
    expect(course.appointments.size).to eq(3)
    expect(appointment1.course).to eq(course)
    expect(appointment2.course).to eq(course)
    expect(appointment3.course).to eq(course)
  end
end
