# == Schema Information
#
# Table name: trades
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  category   :string(255)
#  price      :integer          default(1), not null
#  quantity   :integer          default(1), not null
#  discount   :integer
#  subject    :string(255)
#  trade_no   :string(255)
#  state      :string(255)      default("opening"), not null
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Trade do
  pending "add some examples to (or delete) #{__FILE__}"
end
