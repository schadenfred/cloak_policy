module CloakPolicy
  class ExtensionErrorsController < ApplicationController

    def index
      @extension_errors = ExtensionError.order(created_at: :desc)
    end
  end
end