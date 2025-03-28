Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  #
  root "homepage#show"

  # TODO: make resourceful
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/auth/logout" => "auth0#logout"

  resources :conversations, only: [ :index, :show, :create ] do
    resources :messages, only: [ :create ]
  end

  namespace :users do
    resources :search, only: [ :index ]
  end

  resources :users, only: [ :show, :edit, :update ]
  resources :subscriptions, only: [ :index ]


  resource :onboarding, only: [ :show, :update ], controller: "onboarding"


  namespace :api do
    namespace :v1 do
      namespace :stripe do
        resource :webhook, only: [ :create ]
      end
    end
  end
end
