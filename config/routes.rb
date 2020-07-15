Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get :find, to: "searches#show"
        get :find_all, to: "searches#index"
        get :most_revenue, to: "revenues#index"
        get :most_items, to: "items#index"
      end
      resources :merchants, except: [:new, :edit] do
        resources :items, only: [:index]
      end
      namespace :items do
        get :find, to: "searches#show"
        get :find_all, to: "searches#index"
      end
      resources :items, except: [:new, :edit] do
        get 'merchant', to: "merchants#show"
      end
      get :revenue, to: "revenues#index"
    end
  end
end
