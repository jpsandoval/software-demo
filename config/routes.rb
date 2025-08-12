Rails.application.routes.draw do
  get "homepage/index"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :students, only: [:index, :create]
  end

  root "homepage#index" 
  
  
  get 'hi', to:'hello#sayHi'
  post   "/tickets", to: "tickets#create"
  get    "/tickets/:code/status", to: "tickets#status"
  patch   "/tickets/:code/pay", to: “tickets#pay"
  delete "/tickets/purge_unpaid", to: "tickets#purge_unpaid"


end
