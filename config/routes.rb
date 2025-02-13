Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :registrations, only: %i[ new create ]


  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
