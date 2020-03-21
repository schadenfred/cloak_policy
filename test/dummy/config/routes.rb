Rails.application.routes.draw do
  mount CloakPolicy::Engine => "/cloak_policy"
end
