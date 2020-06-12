require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::PlatformsController < ApplicationController
    def index
      @platforms = CloakPolicy::Platform.all
      render json: CloakPolicy::Api::V1::PlatformSerializer.new(@platforms).serialized_json
    end

    def show
    end
  end
end
