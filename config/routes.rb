Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "/pages/*page",to: "pages#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :requests, excep: [:new, :create, :show]
    resources :categories, except: :show do
      resources :books
    end
  end

  resources :users
  resources :books, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :requests, except: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy, :index]
end
