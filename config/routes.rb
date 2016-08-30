Thirtyone::Application.routes.draw do

  resources :local_resource_categories

  resources :local_resources do
    collection do
      get :search
    end
  end

  resources :visits

  resources :user_roles

  devise_for :users

  resources :calendar, only: [:index]

#  resources :inventory_orders

  scope 'inventory' do
    resources :items, as: 'inventory_items', controller: 'inventory_items'
    resources :orders, controller: 'inventory_orders'

    #TODO: Need to figure out what to name this
    resources :inventory_stock_records
  end

  root  'static_pages#index'

  # If user refreshes the user 'update' page after getting an error, we want to send them to the show person page
  get '/user/:id'  => 'users#show_person'
  resources :user, controller: 'users', only: [:index, :edit, :update]
  resources :role, as: "roles", controller: "roles", via: :all

  match '/roles/bulk', :controller => 'roles', :action => 'bulk_assign_new', via: :get
  match '/roles/bulk', :controller => 'roles', :action => 'bulk_assign_create', via: :post

  resources :event, as: 'events', controller: 'event', via: :all

  resources :households, controller: 'household' do
    collection do
      get :search
      get :select
      get '/:id/merge'            => 'household#merge_select',        as: 'merge_select'
      get '/:id/merge/:merge_id'  => 'household#merge_select_fields', as: 'merge_select_fields'
      patch ':id/merge/:merge_id' => 'household#merge',               as: 'merge'
    end
    resources :addresses
  end

  resources :event, as: "events", controller: "event", via: :all

  resources :work_schedule, as: "work_schedules", controller: "work_schedule", via: :all

  resources :people do
    collection do
      get 'search'
    end
  end

  delete '/user/:id/email_change'     => 'users#cancel_pending_email_change', as: 'cancel_pending_email_change'
  post '/user/:id/email_confirmation' => 'users#send_confirmation_email', as: 'send_confirmation_email'
  get '/user/:id/email_confirmation'  => 'users#confirm_email_change', as: 'confirm_email_change'

  match '/people/new', :controller => 'people', :action => 'new', via: :post
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
