# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  phone                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)
#  name                   :string(255)      default(""), not null
#  age                    :integer
#  sex                    :integer
#  email                  :string(255)
#  qq                     :string(255)
#  hobby                  :string(255)
#  introduction           :string(255)
#  status                 :integer          default(0)
#  identity               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  paper_img              :string(255)
#  paper_id_img           :string(255)
#  image                  :string(255)
#  pay_num                :string(255)
#  teacher_paper          :string(255)
#  professional_paper     :string(255)
#  quotes                 :string(255)
#  experience             :string(255)
#  my_categories          :string(255)
#  number                 :string(255)
#  period                 :integer          default(0)
#  teaching_age           :integer          default(0)
#  study_case             :text
#  join_status            :integer          default(0)
#  score                  :integer          default(0)
#  signdate               :text
#  signcount              :integer
#  qrcode_uid             :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher do
    phone    "15011112222"
    password "123ert678"
    name     "Mike"
    #identity Setting.teachers.identity_student
  end
end
