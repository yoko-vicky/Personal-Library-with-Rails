Rails.application.routes.draw do
  devise_for :users
  resources :images
  resources :tags

  root 'images#index'
end
