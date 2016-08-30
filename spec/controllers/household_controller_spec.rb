require 'rails_helper'

describe HouseholdController, type: :controller do

  context 'without a signed in user' do
    describe 'GET #index' do
      it 'should redirect to the sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'should redirect to the sign in page' do
        get :show, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #merge_select' do
      it 'should redirect to the sign in page' do
        get :merge_select, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #merge_select_fields' do
      it 'should redirect to the sign in page' do
        get :merge_select_fields, id: 1, merge_id: 2
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #merge' do
      it 'should redirect to the sign in page' do
        get :merge, id: 1, merge_id: 2
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #new' do
      it 'should redirect to the sign in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #search' do
      it 'should redirect to the sign in page' do
        get :search
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #search' do
      it 'should redirect to the sign in page' do
        get :search
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  context 'with a signed in user' do
    login_user_rw

    let(:household) { FactoryGirl.create :household }

    describe 'GET #index' do
      it 'should render the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it 'should render the :show template' do
        get :show, id: household.id
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      it 'should render the :edit template' do
        get :edit, id: household.id
        expect(response).to render_template :edit
      end
    end

    describe 'GET #new' do
      it 'should render the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #search' do
      it 'should render the :index template' do
        get :search
        expect(response).to render_template :index
      end
    end

    describe 'GET #merge_select' do
      it 'should render the :merge template' do
        household = FactoryGirl.create :household
        get :merge_select, id: household.id
        expect(response).to render_template :merge
      end
    end

    describe 'GET #merge_select_fields' do
      it 'should render the :merge_select_fields template' do
        household       = FactoryGirl.create :household
        merge_household = FactoryGirl.create :household
        get :merge_select_fields, id: household.id, merge_id: merge_household.id
        expect(response).to render_template :merge_select_fields
      end
    end

  end
end