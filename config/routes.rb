Rails.application.routes.draw do
  resources :waiters
  resources :tables
  resources :items
  resources :menus
  resources :requests
  resources :customers
  devise_for :users
  root 'requests#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
