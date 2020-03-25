module CloakPolicy

  class ChosensController < ApplicationController

    def create
      recommendation = Recommendation.find(chosen_params[:recommendation_id])
      choice = Choice.find(chosen_params[:choice_id])
      setting = choice.setting
      @setting = choice.setting
      @chosen = recommendation.chosens.where(
        choice_id: choice.id,
        setting_id: setting.id ).first_or_create
      if chosen_params["advice"]
        @chosen[:advice] = chosen_params["advice"]
      end
      recommendation.recommend!(choice) if chosen_params[:recommendable].eql? "true"
      respond_to do |format|
        if @chosen.save
          format.html { redirect_back fallback_location: admin_recommendations_path, notice: 'Chosen saved.'  }
          format.js {  render 'create', locals: { setting: setting, choice: choice, recommendation: recommendation} }
          format.json { render :show, status: :created, location: @chosen }
        else
          format.html { redirect_back fallback_location: recommendations_path, notice: 'Chosen was not saved.' }
          format.json { render json: @chosen.errors, status: :unprocessable_entity }
        end
      end
    end

    private

      def chosen_params
        params.require(:chosen).permit(:recommendation_id, :choice_id,
          :setting_id, :advice, :recommendable )
      end
  end
end