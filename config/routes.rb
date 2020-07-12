Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit] do
        get :item, to: 'items#index'
      end
      resources :items, except: [:new, :edit]
    end
  end
end
