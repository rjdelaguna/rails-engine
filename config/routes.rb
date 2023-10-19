Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      get "/merchants/find", to: "search#merchants_find"
      get "/merchants/find_all", to: "search#merchants_find_all"
      
      get "/items/find", to: "search#items_find"
      get "/items/find_all", to: "search#items_find_all"

      resources :merchants, only: [:index, :show] do
        resources :items, controller: "merchant_items", only: [:index]
      end

      resources :items do
       get "/merchant" => "merchant_items#show"
      end
    end
  end


end
