Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users_plants
  resources :users, only: [ :update, :show ] do
    collection do
      patch "me", to: "users#update_me"
    end
  end
  namespace :users do
    resources :care_periods, only: [ :show ]
  end
  resources :plants do
    resources :search, only: [ :show ]
  end
  resources :care_periods
  # Defines the root path route ("/")
  # root "posts#index"
end
