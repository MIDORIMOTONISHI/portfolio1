Rails.application.routes.draw do
  devise_for :users
  root 'start#top'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    collection do
      get 'order_consent'
      patch 'update_order_consent'
    end
    member do
      get 'cart'
      patch 'update_cart'
      get 'orders/edit_cart'
      patch 'orders/update_cart'
    end
    resources :designs do
      resources :orders do
        collection do
          get 'order_show'
          post 'create_order_show'
        end
      end
    end
  end
  resources :designs do
    resources :likes, only: [:create, :destroy]
  end  
end