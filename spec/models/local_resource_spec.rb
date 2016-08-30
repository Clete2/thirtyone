# == Schema Information
#
# Table name: local_resources
#
#  id            :integer          not null, primary key
#  business_name :string
#  phone         :string
#  email         :string
#  url           :string
#  address_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe LocalResource, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
