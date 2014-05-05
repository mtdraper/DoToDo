DoToDo::Application.routes.draw do
  resources :user_sessions

  resources :users

  resources :tasks

  resources :categories
  
  get 'tasks/:id/complete', :to => 'tasks#complete', :as => :complete
  
  get "login", :to => "user_sessions#new"
  
  get "logout", :to => "user_sessions#destroy"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'categories#index'
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      #category routes
      get 'categories/:token', :to => 'categories#index' 
      get 'categories/create/:label/:token', :to => 'categories#create', :as => :category_create    
      
      #task routes
      get 'tasks/:catid/:token', :to => 'tasks#index'  
      get 'tasks/:id/complete/:token', :to => 'tasks#complete', :as => :task_complete
      get 'tasks/create/:catid/:label/:token', :to => 'tasks#create', :as => :task_create
    
      #user routes
      get 'users/login', :to => 'users#login'
      get 'users/logout/:token', :to => 'users#logout'
      get 'users/validate_token/:token', :to => 'users#validate_token'
    
    
    
    
    
    end
  end
  
  
  
  
  
  
  

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
