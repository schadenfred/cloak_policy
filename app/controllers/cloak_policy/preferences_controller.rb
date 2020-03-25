module CloakPolicy

  class PreferencesController < ApplicationController
    before_action :set_preference, only: [:show, :edit, :update, :destroy]

    def index
      @preferences = Preference.all
    end

    def show
    end

    def new
      @preference = Preference.new
    end

    def edit
    end

    def create
      @preference = Preference.new(preference_params)

      respond_to do |format|
        if @preference.save
          format.html { redirect_to admin_preferences_path, notice: 'Preference was successfully created.' }
        else
          format.html { render :new }
          format.json { render json: @preference.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @preference.update(preference_params)
          format.html { redirect_to admin_preferences_path, notice: 'Preference was successfully updated.' }
        else
          format.html { render :edit }
          format.json { render json: @preference.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @preference.destroy
      respond_to do |format|
        format.html { redirect_to preferences_url, notice: 'Preference was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_preference
        @preference = Preference.find(params[:id])
      end

      def preference_params
        params.require(:preference).permit( :name, :icon, :description)
      end
  end
end