module CloakPolicy
  class RecommendationsPlatformsController < ApplicationControllerr
    before_action :set_recommendations_platform, only: [:show]

    def show
    end

    def adjust
      @recommendations_platform = RecommendationsPlatform.find(params[:id])
      respond_to do |format|
        if @recommendations_platform.update(recommendations_platform_params)
          format.js { render 'update', locals: { recommendation: @recommendations_platform.recommendation }}
        end
      end
    end

    private

    def set_recommendations_platform
      @recommendations_platform = RecommendationsPlatform.find(params[:id])
      @recommendation = Recommendation.find(params[:recommendation_id])
      @platform = Platform.find(params[:id])
    end

    def recommendations_platform_params
      params.require(:recommendations_platform).permit(:recommendations_platform_id,
        :recommendation_id, :platform_id)
    end
  end
end