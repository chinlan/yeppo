Rails.application.routes.draw do

  scope :path => '/api/v1/', :defaults => {:format => :json }, :module => "api_v1", :as => 'v1' do
    post "/login" => "auth#login"
    post "/logout" => "auth#logout"
    resources :conversations, only: [:index, :create] do
      resources :messages, only: [:index, :create] 
    end
    resources :relationships, only: [:create, :destroy]
    resources :users, :only => [:index, :show, :edit, :update] 
    resources :shots do
      resources :comments, :only => [:create, :destroy]
      resources :likes, :only => [:create, :destroy]
    end
    
  
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  resources :users, :only => [:show, :edit, :update] do
    resources :shots, :except => [:index] do
      resources :comments, :only => [:create, :destroy], :controller => "shot_comments"
      resources :likes, :only => [:create, :destroy]
    end
    
    member do
      get :following
      get :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :conversations do
    resources :messages
    member do 
      get :more_messages
    end
  end

  namespace :admin do
    resources :shots
    resources :users do
      collection do
        post :bulk_update
      end
    end
  end

  get "/photographers" => "welcome#photographers"
  get "/models" => "welcome#models"
  post "/contact" => "welcome#contact"
  get "/about" => "welcome#about"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'tags/:tag', to: 'welcome#index', as: "tag"

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
