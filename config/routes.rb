Rails.application.routes.draw do
  devise_for :users
  root 'start#top'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :designs
end
