Rails.application.routes.draw do
  get 'requests/tables/:table_id', to: 'requests#table_requests', as: 'table_requests'
  get 'items/menus/:menu_id', to: 'items#items_by_menu', as: 'menu_items'
  get 'tables/:id/bill', to: 'tables#generate_bill', as: 'generate_bill'
  post 'tables/waiters/', to:  'tables#waiter_exists', as: 'waiter_exists'
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
  root 'tables#index'
end
