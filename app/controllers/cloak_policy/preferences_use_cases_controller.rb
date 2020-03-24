require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class PreferencesUseCasesController < ApplicationController
    before_action :set_preferences_use_case, only: [:show, :edit, :update, :destroy]

    # GET /preferences_use_cases
    def index
      @preferences_use_cases = PreferencesUseCase.all
    end

    # GET /preferences_use_cases/1
    def show
    end

    # GET /preferences_use_cases/new
    def new
      @preferences_use_case = PreferencesUseCase.new
    end

    # GET /preferences_use_cases/1/edit
    def edit
    end

    # POST /preferences_use_cases
    def create
      @preferences_use_case = PreferencesUseCase.new(preferences_use_case_params)

      if @preferences_use_case.save
        redirect_to @preferences_use_case, notice: 'Preferences use case was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /preferences_use_cases/1
    def update
      if @preferences_use_case.update(preferences_use_case_params)
        redirect_to @preferences_use_case, notice: 'Preferences use case was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /preferences_use_cases/1
    def destroy
      @preferences_use_case.destroy
      redirect_to preferences_use_cases_url, notice: 'Preferences use case was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_preferences_use_case
        @preferences_use_case = PreferencesUseCase.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def preferences_use_case_params
        params.require(:preferences_use_case).permit(:use_case_id, :preferece_id)
      end
  end
end
