Rails.application.routes.draw do
  devise_for :users
  root 'start#top'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'cart'
      patch 'update_cart'
    end
    resources :designs do
      resources :orders
      # member do
      #   get 'order_show'
      #   patch 'update_order_show'
      # end
    end
  end
  resources :designs do
    resources :likes, only: [:create, :destroy]
  end  
end