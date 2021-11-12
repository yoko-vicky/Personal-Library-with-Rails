Rails.application.routes.draw do
  devise_for :users
  resources :images
  # get '/search', to: 'images#search'
  resources :tags

  root 'images#index'
end
