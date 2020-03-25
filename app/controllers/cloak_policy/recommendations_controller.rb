module CloakPolicy
  class RecommendationsController < ApplicationControllerr
    before_action :set_recommendation, only: [:choose, :show, :edit, :update, :destroy]

    def index
      @recommendations = Recommendation.all
      @house_recommendations = Recommendation.where(housable: true)
      @custom_recommendations = Recommendation.where(housable: false)

    end

    def choose
      @choice = Choice.find(recommendation_params[:choice_ids].first)
      @setting = @choice.setting
      @recommendation.chosens.where(choice_id: @setting.choices.pluck(:id)).delete_all
      @chosen = Chosen.new(
        recommendation_id: @recommendation.id,
        setting_id: @setting.id,
        choice_id: @choice.id,
        recommendable: true,
        advice: recommendation_params["chosens_attributes"]["0"]["advice"]
        )
      respond_to do |format|
        if @chosen.save
          format.html { redirect_to edit_recommendation_path(@recommendation), notice: 'Choice was successfully created.' }
          format.json { render :show, status: :created, location: @recommendation }
          format.js
        else
          format.html { render :new }
          format.json { render json: @recommendation.errors, status: :unprocessable_entity }
          format.js
        end
      end
    end

    def show
    end

    def new
      @recommendation = Recommendation.new
      @recommendable_platforms = Platform.recommendable
      @platforms = [Platform.find_by(name: "facebook")]
    end

    def edit
      @recommendable_platforms = Platform.recommendable

      @platforms = @recommendation.recommendables
    end

    def create
      @recommendation = Recommendation.new(recommendation_params)
      respond_to do |format|
        if @recommendation.save
          format.html { redirect_to edit_recommendation_path(@recommendation), notice: 'Recommendation was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    def update

      respond_to do |format|
        if @recommendation.update(recommendation_params)
          format.html { redirect_to [:admin, @recommendation], notice: 'Recommendation was successfully updated.' }
        else
          format.html { render :edit }
          format.json { render json: @recommendation.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @recommendation.destroy
      respond_to do |format|
        format.html { redirect_to admin_recommendations_url, notice: 'Recommendation was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_recommendation
        @recommendation = Recommendation.find(params[:id])
      end

      def set_platforms
        @platforms = Platform.all
      end

      def recommendation_params
        params.require(:recommendation).permit(:benefit, :name, :description, :profile, :expectation, :housable, :use_case, :choice, :choices, :choice_ids, :choice_id, platform_ids: [], choice_ids: [], chosens_attributes: {})
      end
  end
end
