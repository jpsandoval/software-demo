Rails.application.routes.draw do
  get "homepage/index"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :students, only: [:index, :create]
  end

  root "homepage#index" 
  
  
  get   "/hi", to: "hello#sayHi"

   # 1) Create ticket
  post   "/tickets", to: "tickets#create"
  # 2) Pay ticket (by code)
  # 9c3bbcaa63
  patch   "/tickets/:code/pay", to: "tickets#pay"
  # 3) Check-in
  patch "/tickets/:code/checkin", to: "tickets#checkin"
  # 4) Purge unpaid tickets older than 2 days
  delete "/tickets/purge_unpaid", to: "tickets#purge_unpaid"

  # 5) Get ticket status by code
  get    "/tickets/:code/status", to: "tickets#status"
end
