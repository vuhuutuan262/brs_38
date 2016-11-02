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

  resources :books, only: [:index, :show] do
    resources :review_rates, except: :index
    resources :book_marks, only: [:create, :update, :edit]
  end
  resources :review_rates, except: :index do
    resources :comments, except: [:index, :show]
  end
  resources :users
  resources :categories, only: :show
  resources :requests, except: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy, :index]
  resources :activities, only: :index do
    resources :like_activities, only: [:create, :destroy]
  end
  resources :dashboards, only: :index
end
