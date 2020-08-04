Rails.application.routes.draw do
  devise_for :users
  root 'start#top'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    resources :designs, only: [:order_show, :update_order_show] do
      member do
        get 'designs/order_show'
        patch 'designs/update_order_show'
      end
    end
  end
  resources :designs do
    resources :likes, only: [:create, :destroy]
    resources :order
      
  end  
end