Rails.application.routes.draw do

  get 'statistics/index'

  get 'twitter/tweet'
  get 'transportation/connection'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  resources :trainings do
    get 'join', to: 'trainings#join'
    get 'leave', to: 'trainings#leave'
    get 'invite', to: 'trainings#invite'
    resource :comments, only: [:new, :destroy, :create]
    resources :trainingsessions, controller:'training_sessions', only: [:destroy, :create, :new, :edit, :update] do
      resources :logs, only: [:destroy, :create, :new, :edit, :update]
    end
  end

  get 'mytrainings', to: 'trainings#mytrainings'
  get 'auth/facebook/callback', to: 'sessions#facebook'
  get 'auth/twitter/callback', to: 'sessions#twitter'

  post 'chats/:partner_id', to: 'chats#create', as: 'chat_create'

  resources :chats, only: [:index, :destroy, :show, :update, :edit] do
    resources :messages, only: [:create, :new, :show]
  end


  resources :training_notifiers

  resources :calendar, only: [:index]
  resources :statistics

  resources :friends
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :local_users
  resource :profile, :controller => :profile, only: [:show, :edit, :update]
  get 'profile/:username', to: 'profile#profile', as: 'user_profile'
  #get 'profile', to: 'profile#show' #not necessary anymore

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
