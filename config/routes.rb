Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contacts', to: 'static_pages#contacts'
  get '/signup', to: 'users#new'
  resources :users
end
