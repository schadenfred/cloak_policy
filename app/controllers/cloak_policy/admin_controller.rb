module CloakPolicy
  class ApplicationControllerr < ApplicationController
    before_action :authenticate_user!

    layout 'admin'
  end
end