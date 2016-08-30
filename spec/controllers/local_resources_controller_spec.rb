require 'rails_helper'

describe LocalResourcesController, type: :controller do

  context 'without a signed in user' do
    describe 'GET #search' do
      it 'should redirect to the sign in page' do
        get :search
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'with a signed in user' do
    login_admin

    describe 'GET #search' do
      it 'should render the :search_results template' do
        get :search, search: {term: 'anything', local_resource_categories: ['1']}
        expect(response).to render_template 'local_resources/_search_results'
      end
    end
  end

end