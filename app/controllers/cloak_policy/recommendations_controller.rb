require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class RecommendationsController < ApplicationController
    before_action :set_recommendation, only: [:show, :edit, :update, :destroy]

    # GET /recommendations
    def index
      @recommendations = Recommendation.all
    end

    # GET /recommendations/1
    def show
    end

    # GET /recommendations/new
    def new
      @recommendation = Recommendation.new
    end

    # GET /recommendations/1/edit
    def edit
    end

    # POST /recommendations
    def create
      @recommendation = Recommendation.new(recommendation_params)

      if @recommendation.save
        redirect_to @recommendation, notice: 'Recommendation was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /recommendations/1
    def update
      if @recommendation.update(recommendation_params)
        redirect_to @recommendation, notice: 'Recommendation was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /recommendations/1
    def destroy
      @recommendation.destroy
      redirect_to recommendations_url, notice: 'Recommendation was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_recommendation
        @recommendation = Recommendation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def recommendation_params
        params.require(:recommendation).permit(:name, :description, :recommender_id)
      end
  end
end
