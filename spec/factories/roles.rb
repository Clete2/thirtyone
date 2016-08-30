# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string
#  permissions :integer          default(0)
#

FactoryGirl.define do
  factory :role do
    name { Faker::Lorem.word }

    factory :admin_role do
      name 'Admin'
      permissions PERM_ADMIN
    end

    factory :person_ro_role do
      name 'RO_Person'
      permissions PERM_RO_PERSON
    end

    factory :person_rw_role do
      name 'RW_Person'
      permissions PERM_RW_PERSON
    end
  end
end
