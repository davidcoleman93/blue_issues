BlueIssues::Application.routes.draw do
  
  #resources :issue_logs

  #resources :accesss
  #resources :access, only: [:create]
  resources :sessions, only: [:create]
  #resources :accesses
  resources :departments
  resources :users
  
  resources :issues do
	resources :watchers
  end
#resources :issues	
#resources :posts
  
  resources :issues do
	resources :posts
  end
  
  resources :issues do
	resources :issue_logs
  end


  #get "departments/index"
  #get "departments/show"
  #get "departments/new"
  #get "departments/edit"
  #get "departments/delete"
  #get "issues/index"
  #get "issues/show"
  #get "issues/new"
  #get "issues/edit"
  #get "issues/delete"
  
  #get "access/index"
  #get "/signin" => "sessions#new"
  #get "/signout" => "sessions#destroy"
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  #get "access/login"
  #get "access/new"
  
  #get "access/show"
  #get "issues/departmentissues"
  #get "issues/myissues"
  get 'departmentissues', to: 'issues#departmentissues'
  get 'myissues', to: 'issues#myissues'
  get 'mytasks', to: 'issues#mytasks'
  get 'mypastissues', to: 'issues#mypastissues'
  get 'mypasttasks', to: 'issues#mypasttasks'
  get 'pastdeptissues', to: 'issues#pastdepartmentissues'
  #resources :users do		
		#resources :issues
		#get :issues
  #end
 
  
  #get "users/index"
  #get "users/show"
  #get "users/new"
  #get "users/edit"
  #get "users/delete"

  
  get "home/index"
  root "home#index"
  
  get 'user', :to => "sessions#index"
  
 match ':controller(/:id(/:action))' , :via => [:get, :post]
 #match ':controller(/:action(/:id))' , :via => [:get, :post]
 
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
