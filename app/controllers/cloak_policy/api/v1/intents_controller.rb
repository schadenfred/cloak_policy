require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::IntentsController < ApplicationController

    def index 
      @intents = CloakPolicy::Intent.all
      render json: CloakPolicy::Api::V1::IntentSerializer.new(@intents).serialized_json
    end 

    def show 

    end
  end
end
