Rails.application.routes.draw do
  resources :waiters
  resources :tables
  resources :items
  resources :menus
  resources :requests do
    patch '/amounts', to: 'requests#create_amounts'
    get '/amounts/all', to: 'requests#find_amounts'
    delete '/amounts/:id/delete', to: 'requests#delete_amount'
  end
  resources :customers
  devise_for :users
  root 'requests#index'
end
