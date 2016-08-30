require 'rails_helper'

describe PeopleController, type: :controller do

  context 'without a signed in user' do
    describe 'GET #index' do
      it 'should redirect to the sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #search' do
      it 'should redirect to the sign in page' do
        get :search
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'should redirect to the sign in page' do
        person = FactoryGirl.create :person
        get :show, id: person.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #new' do
      it 'should redirect to the sign in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'should redirect to the sign in page' do
        person = FactoryGirl.create :person
        get :edit, id: person.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'should redirect to the sign in page' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PUT #update' do
      it 'should redirect to the sign in page' do
        person = FactoryGirl.create :person
        put :update, id: person.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'should redirect to the sign in page' do
        person = FactoryGirl.create :person
        delete :destroy, id: person.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'with a signed in user' do
    login_user_rw

    describe 'GET #index' do
      it 'should render the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #search' do
      it 'should render the :index template' do
        get :search
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it 'should render the :show template' do
        person = FactoryGirl.create :person
        get :show, id: person.id
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it 'should render the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'should render the :edit template' do
        person = FactoryGirl.create :person
        get :edit, id: person.id
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      attributes_with_foreign_keys(:person)

      context 'with valid parameters' do
        xit 'should save the new person in the database' do
          expect {
            post :create, person: person_with_foreign_keys
          }.to change(Person, :count).by(1)
        end

        xit 'should redirect to :person_path' do
          post :create, person: person_with_foreign_keys
          expect(response).to redirect_to(person_path(assigns(:person)))
        end
      end

      context 'with invalid parameters' do
        xit 'should not save the new person in the database' do
          expect {
            post :create, person: attributes_for(:invalid_person)
          }.not_to change(Person, :count)
        end

        xit 'should render the :new template' do
          post :create, person: attributes_for(:invalid_person)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PUT #update' do
      attributes_with_foreign_keys(:person, firstname: 'New')
      before(:each) do
        @person = FactoryGirl.create :person
      end

      context 'with valid parameters' do
        xit 'should locate the requested person' do
          put :update, id: @person, person: person_with_foreign_keys
          expect(assigns(:person)).to eq(@person)
        end

        xit 'should change the persons attributes' do
          put :update, id: @person, person: person_with_foreign_keys
          @person.reload
          expect(@person.firstname).to eq('New')
        end

        xit 'should redirect to the updated person' do
          put :update, id: @person, person: person_with_foreign_keys
          expect(response).to redirect_to(@person)
        end
      end

      context 'with invalid parameters' do
        xit 'should not change the person attributes' do
          put :update, id: @person, person: attributes_for(:person, firstname: nil)
          @person.reload
          expect(@person.firstname).not_to eq(nil)
        end

        xit 'should render the :edit template' do
          put :update, id: @person, person: attributes_for(:invalid_person)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destory' do
      before(:each) do
        @person = FactoryGirl.create :person
      end

      it 'should locate the requested person' do
        delete :destroy, id: @person
        expect(assigns(:person)).to eq(@person)
      end

      it 'should remove the person from the database' do
        expect {
          delete :destroy, id: @person
        }.to change(Person, :count).by(-1)
      end

      it 'should redirect to the people_url' do
        delete :destroy, id: @person
        expect(response).to redirect_to(people_url)
      end
    end
  end

  context 'with a signed in admin user' do
    login_admin

    describe 'Get #index' do
      it 'should render the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end



end
