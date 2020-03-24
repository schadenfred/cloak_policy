require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class ChoicesController < ApplicationController
    before_action :set_choice, only: [:show, :edit, :update, :destroy]

    # GET /choices
    def index
      @choices = Choice.all
    end

    # GET /choices/1
    def show
    end

    # GET /choices/new
    def new
      @choice = Choice.new
    end

    # GET /choices/1/edit
    def edit
    end

    # POST /choices
    def create
      @choice = Choice.new(choice_params)

      if @choice.save
        redirect_to @choice, notice: 'Choice was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /choices/1
    def update
      if @choice.update(choice_params)
        redirect_to @choice, notice: 'Choice was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /choices/1
    def destroy
      @choice.destroy
      redirect_to choices_url, notice: 'Choice was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_choice
        @choice = Choice.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def choice_params
        params.require(:choice).permit(:name, :setting_id, :we_say, :they_say, :recommendable, :development_recommendation_id)
      end
  end
end
