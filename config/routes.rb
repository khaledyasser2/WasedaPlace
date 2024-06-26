Rails.application.routes.draw do
  root "static_pages#home"
  get '/help', to:'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get "/login", to: "sessions#new"
  get '/signup', to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :booking
  resources :account_activations, only: [:edit]
end
