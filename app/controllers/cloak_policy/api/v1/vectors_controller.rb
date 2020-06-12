require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::VectorsController < ApplicationController
    def index
      @vectors = CloakPolicy::Vector.all
      render json: CloakPolicy::Api::V1::VectorSerializer.new(@vectors).serialized_json
    end

    def show
    end
  end
end
