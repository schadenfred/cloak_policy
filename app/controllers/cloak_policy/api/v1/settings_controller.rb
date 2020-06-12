require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::SettingsController < ApplicationController
    def index
      @settings = CloakPolicy::Setting.all
      render json: CloakPolicy::Api::V1::SettingSerializer.new(@settings).serialized_json
    end

    def show
    end
  end
end
