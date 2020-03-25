module CloakPolicy
  class ExtensionErrorsController < ApplicationControllerr

    def index
      @extension_errors = ExtensionError.order(created_at: :desc)
    end
  end
end