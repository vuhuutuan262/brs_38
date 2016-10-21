Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "/pages/*page",to: "pages#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:show, :create, :new]
  resources :books, only: [:index, :show]
  resources :categories, only: [:index, :show]
end
