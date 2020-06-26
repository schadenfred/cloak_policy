require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class Api::V1::RecommendationsController < ApplicationController

    before_action :set_recommendation, only: [:show]


    def index
      @recommendations = CloakPolicy::Recommendation.all
      render json: CloakPolicy::Api::V1::RecommendationSerializer.new(@recommendations).serialized_json
    end

    def show
      
      render json: CloakPolicy::Api::V1::RecommendationSerializer.new(@recommendation).serialized_json
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_recommendation
        @recommendation = CloakPolicy::Recommendation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def chosen_params
        params.require(:recommendation).permit(:name)
      end
  end
end
