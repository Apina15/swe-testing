Rails.application.routes.draw do
  root 'items#index'

  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'
  get 'access/unauthorized'

  resources :users do
      member do
          get :delete
          get :manage
          patch :manage_update
        end
      end

  # get all the urls, including delete
  resources :items do
    member do
      get :delete
    end
  end

# add new views before others so they are parsed and routed properly
  get 'transactions/checkout', to:'transactions#checkout'
  post 'transactions/submit'
  get 'transactions/showAllUserItems'

  resources :transactions do
   member do
     get :delete
   end
  end
  #Manual so it recognizes new views
  #get 'transactions', to: 'transactions#index'
  #get 'transactions/show'
  #get 'transactions/new'
  #get 'transactions/edit'
  #get 'transactions/delete'

  resources :log, only: [:index]
  
  get 'users/key', to: 'users#will_checkout_or_return_key'
  post 'users/key', to: 'users#checkout_or_return_key'

  #get 'items/index'
  #get 'items/show'
  #get 'items/new'
  #get 'items/edit'
  #get 'items/delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
