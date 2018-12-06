# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  weekday    :integer
#  time       :integer
#  course_id  :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#  teacher_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :appointment_1, class: Appointment do
    weekday Setting.appointments.weekday_monday
    time    Setting.appointments.time_morning
  end

  factory :appointment_2, class: Appointment do
    weekday Setting.appointments.weekday_tuesday
    time    Setting.appointments.time_morning
  end

  factory :appointment_3, class: Appointment do
    weekday Setting.appointments.weekday_wednesday
    time    Setting.appointments.time_morning
  end
end
