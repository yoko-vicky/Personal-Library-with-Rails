Rails.application.routes.draw do
  devise_for :users
  root 'images#index'

  resources :images
  resources :tags

  post 'taggings', to: 'images#taggings'
end
