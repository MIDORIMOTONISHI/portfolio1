Rails.application.routes.draw do
  devise_for :users
  root 'start#top'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/callback' => 'linebot#callback'
  get '/line', to: 'sessions#line'

  resources :users do
    member do
      get 'cart'
      patch 'update_cart'
      get 'orders/edit_cart'
      patch 'orders/update_cart'
      get 'order_consent'
      patch 'update_order_consent'
      get 'order_sending'
      patch 'update_order_sending'
      get 'order_receiving'
      patch 'update_order_receiving'
      get 'admin_order_log'
      get 'designer_order_log'
      get 'customer_order_log'
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