module CloakPolicy
  class UseCasesController < ApplicationController
    before_action :set_use_case, only: [:show, :edit, :update, :destroy]

    def edit
    end

    def create
      @use_case = UseCase.new(use_case_params)
      respond_to do |format|
        if @use_case.save
          format.html { redirect_to use_cases_path, notice: 'UseCase was successfully created.' }
          format.json { render :show, status: :created, location: @use_case }
        else
          format.html { render :new }
          format.json { render json: @use_case.errors, status: :unprocessable_entity }
        end
      end
    end

    def update

      respond_to do |format|
        if @use_case.update(use_case_params)
          format.html { redirect_to edit_use_case_path(@use_case), notice: 'UseCase was successfully updated.' }
          format.js { redirect_to edit_use_case_path(@use_case), notice: 'UseCase was successfully updated.' }
          format.json { render :show, status: :ok, location: @use_case }

        else
          format.html { render :edit }
          format.json { render json: @use_case.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @use_case.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: [:admin, @use_case.profile], notice: 'UseCase was successfully destroyed.' }
      end
    end

    private

      def set_use_case
        @use_case = UseCase.find(params[:id])
      end

      def use_case_params
        params.require(:use_case).permit(:profile_id, :recommendation_ids, :name, :icon, :description, preference_ids: [], recommendations_use_case_attributes: [:recommendation_id])
      end
  end
end