Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resources :passwords, only: %i[new create edit update], param: :token
  resource :registrations, only: %i[ new create ]

  resources :books, only: [ :index, :show ] do
    member do
      post "borrow"
      post "return_book"
    end
  end

  get "profile", to: "users#profile", as: "profile"

  root "books#index"

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
