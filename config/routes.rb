Rails.application.routes.draw do
  root 'access#menu'
  #get 'admin', : to => 'access#menu"
  get 'access/menu'
  get 'access/user_menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'
  get 'access/unauthorized'
  
  resources :users, :except => [:show] do
      member do
          get :delete
        end
      end

  #root 'items#index'

  # get all the urls, including delete
  resources :items do
    member do
      get :delete
    end
  end

  get 'checkout', to: 'checkout#index'
  post 'checkout/submit'
  get 'checkout/showAll'
  get 'checkout/myItems'
  get 'checkout/show'
  get 'checkout/myitem_show'
  get 'checkout/showAllUserItems'

  get 'return', to: 'return#index'
  get 'return/index_merch'
  post 'return/submit'

  get 'users/key', to: 'users#will_checkout_or_return_key'
  post 'users/key', to: 'users#checkout_or_return_key'
  
  #get 'items/index'
  #get 'items/show'
  #get 'items/new'
  #get 'items/edit'
  #get 'items/delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
