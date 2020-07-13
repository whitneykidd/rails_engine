Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit] do
        resources :items, only: [:index]
      end
      resources :items, except: [:new, :edit] do
        get 'merchant', to: "merchants#show"
      end
    end
  end
end
