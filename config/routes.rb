Rails.application.routes.draw do
  get 'requests/tables/:table_id', to: 'requests#table_requests', as: 'table_requests'
  resources :waiters
  resources :tables do
    get '/bill', to: 'tables#generate_bill', as: 'generate_bill'
  end
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
