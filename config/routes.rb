Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  resources :users
  get     '/about', to: 'static_pages#about'
  get      '/help', to: 'static_pages#help'
  get  '/contacts', to: 'static_pages#contacts'
  get    '/signup', to: 'users#new'
  get     '/login', to: 'sessions#new'
  post    '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
