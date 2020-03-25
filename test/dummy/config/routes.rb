Rails.application.routes.draw do
  mount CloakPolicy::Engine => "/policy"
end
