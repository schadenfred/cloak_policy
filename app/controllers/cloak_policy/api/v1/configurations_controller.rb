require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::ConfigurationsController < ApplicationController
    def show
      spindle_title = "Cloaking Spindle"
      vectors = CloakPolicy::Vector.top_level
      sv = CloakPolicy::Api::V1::VectorSerializer.new(vectors).serializable_hash
      case params[:id]
      when '1'
        render json: { 
          id: 'top',
          type: 'vector',
          attributes: { 
            name: spindle_title, 
            icon: ""
          },
          relationships: {
            subvectors: sv
          }
        }
      when '2'
        platforms = CloakPolicy::Platform.all
        sp = CloakPolicy::Api::V1::PlatformSerializer.new(platforms).serializable_hash 
        sp[:data].each { |p| p[:relationships][:subvectors] = sv }
        render json: { 
          id: 'top',
          type: 'vector',
          attributes: { 
            name: spindle_title, 
            icon: ""
          },
          relationships: {
            platforms: sp
          }
        } 
      end
    end
  end
end
