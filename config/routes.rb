Rails.application.routes.draw do
  get 'onlines/index'
  get 'sessions/new'
  get 'user/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/password_reset', to: 'password_resets#form_email', as: 'password_reset'
  post '/password_reset', to: 'password_resets#create', as: 'password_resets_new'
  get '/password_reset/:id/edit', to: 'password_resets#edit', as: 'edit_password_reset'
  patch '/password_reset/:id/edit', to: 'password_resets#update', as: 'update_password_reset'
  resources :users
  resources :account_activations, only: [:edit]
  resources :rooms, only: [:show, :create, :index]
  resources :onlines
  resources :search_users, only: [:create]

  resources :messages, only: [:create, :update, :destroy]

  mount ActionCable.server => '/cable'
end
