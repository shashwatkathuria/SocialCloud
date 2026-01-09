Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "users#index"
  end

  devise_for :users

  get "up", to: "rails/health#show", as: :rails_health_check

  # POSTS
  get  "posts/index"
  get  "posts/new"
  post "posts/create"

  get  "posts/search/:searchQuery", to: "posts#search"
  post "posts/search"
  get  "posts/search", to: "welcome#index"

  get  "posts/delete/:deleteID", to: "posts#delete"

  # USERS
  get "users/follow/:username",   to: "users#follow"
  get "users/unfollow/:username", to: "users#unfollow"

  devise_scope :user do
    get "/users/sign_out", to: "devise/sessions#destroy"
  end

  get "/contact_us", to: "contact_us#index"

  get "welcome/index"
  get "/signup", to: "users#new"

  # USERS RESOURCES
  resources :users, only: [:index, :new, :create] do
    collection do
      get  :search
      post :search
    end
  end

  # POSTS RESOURCES
  resources :posts, only: [:index, :new, :create, :show] do
    member do
      get :delete
    end
  end

  # ROOT
  root to: "welcome#index"

  # GLOBAL SEARCH (THIS CREATES search_path)
  post "/search", to: "users#search"
  get  "/search/:searchQuery", to: "users#search"

  # PROFILE PAGE
  get "users/:username", to: "users#show_profile"

  # FALLBACK
  get "*path", to: redirect("/404.html")
end
