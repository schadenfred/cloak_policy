CloakPolicy::Engine.routes.draw do

  resources :settings
  resources :preferences_use_cases
  resources :chosens
  resources :choices
  resources :feedbacks, only: [:create, :index, :destroy]

  resources :profiles
  resources :preferences
  resources :use_cases, only: [:edit, :create, :update, :destroy]
  resources :vectors
  resources :extension_errors,          only: :index

    resources :scores
  resources :users

  resources :recommendations, :platforms, :settings do
      end
  resources :categories do
    member do
      patch :move
    end
  end

  resources :recommendations do
    resources :platforms, controller: 'admin/recommendations_platforms'
    member do
      patch 'choose'
    end
    resources :settings, only: [] do
      get 'launch'
    end
  end
  resources :settings do
    post :update_row_order, on: :collection
  end
  resources :settings, :choices, :platforms, except: [:index] do
    member do
      patch 'activate'
      patch 'deactivate'
    end
  end

  patch 'adjust', to: "scoring#adjust"
  post 'clone',               to: "clones#clone"

  get '',                to: "dashboard#show"
end
