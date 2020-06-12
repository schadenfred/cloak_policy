require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::ConfigurationsController < ApplicationController
    def show
      
      if params[:id].eql?('1')
        @vectors = CloakPolicy::Vector.top_level
        render json: { 
          id: 'top',
          type: 'vector',
          attributes: { 
            name: "CloakingSpindle", 
            icon: ""
          },
          relationships: {
            subvectors: CloakPolicy::Api::V1::VectorSerializer.new(@vectors).serializable_hash
          }
        } 
      end
    end
  end
end
