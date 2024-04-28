Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "index#index"

  # Monolith
  resources :weighing_entries, only: %i[index create update destroy]
  resources :foods
  resources :meal_entries, only: %i[index create update destroy]

  # API
  namespace :api do
    resources :weighing_entries, only: %i[index show create update destroy]
    resources :foods, only: %i[index show create update destroy]
    resources :meal_entries, only: %i[index show create update destroy]
  end
end
