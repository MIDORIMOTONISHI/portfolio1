Rails.application.routes.draw do
  root 'start#top'

  resources :users do
  end
end
