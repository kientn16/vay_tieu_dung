Rails.application.routes.draw do
  root to: "home#index"
  controller :register do
    get 'register' => :new, as: :get_register
    post 'register' => :create, as: :post_register
    get 'active_code' => :active_code, as: :get_active_code
    post 'active_code' => :create_active_code, as: :post_active_code
  end
  controller :sessions do
    get 'login' => :new, as: :get_login
    post 'login' => :create, as: :post_login
    get 'logout' => :destroy, as: :get_logout
  end
  #social authenticate
  get 'auth/facebook/callback', to: 'sessions#create_face'
  get 'auth/google_oauth2/callback', to: 'sessions#create_google'
  get 'auth/failure', to: redirect('/')
  get '/signout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :contacts
  scope "/admin" do
    # get '/' => "contents#index", as: :root_admin
    # resources :contents
    # resources :admins
    controller :sessions do
      get 'login' => :login_admin, as: :get_login_admin
      post 'login' => :create_admin, as: :post_login_admin
      get 'logout' => :destroy_admin, as: :get_logout_admin
    end

    # controller :admin_users do
    #   get 'users' => :index, as: :get_users
    #   get 'users/:id' => :edit, as: :get_edit_user
    #   patch 'users/:id' => :update, as: :post_update_user
    # end
  end

  namespace :admin do
    get '/' => "contents#index", as: :root_admin
    # root :to => 'admin/contents#index'
    resources :contents,:drawdowns,:users,:admins
  end
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
