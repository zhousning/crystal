# == Schema Information
#
# Table name: certificates
#
#  id                  :integer          not null, primary key
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Certificate < ActiveRecord::Base
  attr_accessible :avatar
  #has_attached_file :avatar

  def to_json_picture
    {
      "name" => read_attribute(:avatar_file_name),
      "size" => read_attribute(:avatar_file_size),
      "url" => avatar.url(:originl),
      "delete_url" => certificate_path(self),
      "delete_type"=> "DELETE"
    }
  end
end
