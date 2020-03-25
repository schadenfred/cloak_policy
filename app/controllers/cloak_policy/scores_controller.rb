module CloakPolicy
  class ScoresController < ApplicationController

    before_action :set_score, only: [:update, :destroy]
    before_action :set_scorable, only: [:index, :adjust, :show]

    def show
      @vector = Vector.find(params[:id])
    end

    def index
      @vectors = Vector.all
    end

    def create
      scorable_type = score_params[:scorable_type]
      scorable_id = score_params[:scorable_id]
      vector_id = score_params[:vector_id]
      @scorable = score_params[:scorable_type].constantize.find(scorable_id)
      @score = @scorable.scores.new(points: 100, vector_id: vector_id)
      respond_to do |format|
        if @score.save
          format.js { redirect_back fallback_location: root_path, notice: 'scored!' }
        else
          format.js { redirect_back fallback_location: root_path, notice: 'failed to create score' }
        end
      end
    end

    def update
      @score = Score.find(params[:id])
      respond_to do |format|
        if @score.update(points: score_params[:points])
          format.js { redirect_back fallback_location: root_path, notice: 'score updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @score.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: 'score updated.' }
      end
    end

    private

    def set_scorable
      case
      when params[:recommendation_id]
        @scorable = Recommendation.find(params[:recommendation_id])
      when params[:platform_id]
        @platform = Platform.find(params[:platform_id])
      when params[:setting_id]
        @scorable = Setting.find(params[:setting_id])
      when params[:preference_id]
        @scorable = Preference.find(params[:preference_id])
      end

    end

    def set_score
      @score = Score.find(params[:id])
    end

    def score_params
      params.require(:score).permit(:points, :impact, :scorable_type, :scorable_id, :vector_id)
    end
  end
end