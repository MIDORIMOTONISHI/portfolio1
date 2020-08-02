Rails.application.routes.draw do
  devise_for :users
  root 'start#top'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users

  resources :designs do
    member do
      get 'order_show'
      patch 'update_order_show'
    end
    resources :likes, only: [:create, :destroy]
  end
end