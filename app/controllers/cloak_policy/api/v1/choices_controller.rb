require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::ChoicesController < ApplicationController
    def index
      @choices = CloakPolicy::Choice.all
      render json: CloakPolicy::Api::V1::ChoiceSerializer.new(@choices).serialized_json
    end

    def show
    end
  end
end
