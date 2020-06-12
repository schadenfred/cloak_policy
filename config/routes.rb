CloakPolicy::Engine.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :intents, :vectors, :settings, :platforms, 
                :choices, :configurations, only: [:index, :show]
    end
  end

  scope :policy do 
      
    resources :choices
    resources :chosens
    resources :intents
    resources :platforms
    resources :recommendations
    resources :scores
    resources :settings
    resources :vectors 

    resources :settings do
      post :update_row_order, on: :collection
    end

    resources :settings, :choices, :platforms, except: [:index] do
      member do
        patch 'activate'
        patch 'deactivate'
      end
    end

    patch 'recommendables/activate'
    patch 'recommendables/deactivate'

    patch 'adjust', to: "scoring#adjust"
    post  'clone',               to: "clones#clone"

    get '',                to: "vectors#index"
  end
end