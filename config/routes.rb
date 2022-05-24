Rails.application.routes.draw do
  get "/", to: "welcome#index"
  # get "/users", to: "users#show"
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/dashboard", to: "users#show"

  resources :users, only: [:new] do
    resources :discover, only: [:index], controller: "movies"
    resources :movies, only: [:show] do
      resources :parties, only: [:new, :create]
    end
  end
end
