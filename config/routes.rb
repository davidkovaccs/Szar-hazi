SzarHazi::Application.routes.draw do
  resources :stock_vols

  get "users/index"

  match 'users/:id' => 'users#show'

  get "users/show"

  get "accounts/list"
  
  get "accounts/listall"
  
   get "orders/list"
   
    get "transactions/list"
  
  devise_for :users
  resources :users, :only => [:index, :show]
  resources :transactions

  resources :orders

  resources :accounts

  resources :stocks

  root :to => "home#index"

  match 'buy' => 'home#buy'
  match 'sell' => 'home#sell'
  match 'show_accounts' => 'home#show_accounts'
  match 'show_orders' => 'home#show_orders'
  match 'new_order' => 'home#new_order'
  match 'accounts/:id/activate' => 'accounts#activate'
  match 'users/:id/activate' => 'users#activate'
  match 'users/:id/deactivate' => 'users#deactivate'
  match 'users/:id/edit' => 'users#edit'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
