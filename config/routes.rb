Rails.application.routes.draw do
  
  resources :images
  resources :tags

  root 'images#index'
  
end
