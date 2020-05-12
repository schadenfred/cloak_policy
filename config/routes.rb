CloakPolicy::Engine.routes.draw do

  resources :chosens
  resources :recommendations
  resources :settings
  resources :choices
  resources :vectors

  resources :scores

  resources :recommendations, :platforms, :settings do
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

  patch 'recommendables/activate'
  patch 'recommendables/deactivate'

  patch 'adjust', to: "scoring#adjust"
  post  'clone',               to: "clones#clone"

  get '',                to: "vectors#index"
end
