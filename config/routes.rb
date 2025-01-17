Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get "/register", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"

  get "/discover", to: "movies#discover"
  get "/dashboard", to: "dashboard#show"

  resources :users, only: [:create]

  resources :movies, only: [:index, :show] do
    resources :viewing_parties, only: [:new, :create, :destroy]
  end
  
  resources :viewing_party_invitees, only: [:destroy]

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :users, only: [:show, :destroy]
  end

end
