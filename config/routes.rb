Ququ::Application.routes.draw do
  resources :project_prizes
  resources :comments
  resources :categories
  resources :project_updates
  resources :projects do
    get :progress
    get :comments
    get :supporters
    get :set_project_success
    get :set_project_fail
    collection do
      get :not_support_this_project
      get :list_supporters
      get :welcome
      post :search
      get :support_this_project
      get :recent_updated_followed
    end
  end

  resources :user do
    get :projects
    get :messages
    get :supported_projects
    get :friends
    get :fans
    collection do
      get :add_friend
      get :delete_friend
      get :validate_name
      get :validate_email
    end
  end

  resources :user_session
  resources :messages do
    collection do 
      get :reply
      post :send_reply
    end
  end

  match 'lost_password' => 'user#lost_password', :as => :lost_password
  match 'password_recover' => 'user#password_recover', :as => :password_recover
  
  match 'about' => 'projects#aboutus', :as => :about
  match 'contact' => 'projects#contactus', :as => :contact
  match 'sign_in' => "user_session#new", :as => :sign_in
  match 'sign_up' => 'user#signup', :as => :sign_up
  match 'sign_out' => "user_session#destroy", :as => :sign_out
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "projects#welcome"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
