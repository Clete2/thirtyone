module ControllerMacros
  def login_user_ro
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user, :with_person_ro_role)
    end
  end

  def login_user_rw
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user, :with_person_rw_role)
    end
  end

  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:user, :with_admin_role)
    end
  end

  def attributes_with_foreign_keys(*args)
    let(:person_with_foreign_keys) do
      FactoryGirl.build(*args).attributes.delete_if do |k, v|
        ["id", "type", "created_at", "updated_at"].member?(k)
      end
    end
  end
end
