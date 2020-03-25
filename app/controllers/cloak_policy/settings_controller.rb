module CloakPolicy
  class SettingsController < ApplicationController
    before_action :set_setting, only: [:show, :edit, :adjust, :update, :destroy, :activate, :deactivate]

    def update_row_order
      klass = params.keys.first.classify.constantize
      orderable_params = params[params.keys.first]
      @orderable = klass.find(orderable_params[:orderable_id])
      @orderable.row_order_position = orderable_params[:row_order_position]
      @orderable.save
      render body: nil
    end

    def launch
      @recommendation = Recommendation.find(params[:recommendation_id])
      chosen = @recommendation.chosens.find_by_setting_id(params[:setting_id])
      @setting = Api::V2::ChosenSerializer.new(chosen)
      respond_to :js
    end

    def show
      respond_to do |f|
        f.js { render 'show', locals: { setting: @setting }}
      end
    end

    def new
      @platform = Platform.find(params["platform_id"])
      @setting = @platform.settings.new
      @choice = @setting.choices.build
      respond_to do |f|
        f.js { render 'new', locals: { setting: @setting }}
      end
    end

    def activate

      respond_to do |format|
        if @setting.activate!
          format.js { render 'update', locals: { setting: @setting }}

          format.html { redirect_back fallback_location: root_path, notice: 'setting activated.' }
        else
          format.html { render :new }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end

    def deactivate
      respond_to do |format|
        if @setting.deactivate!
          format.js { render 'update', locals: { setting: @setting }}

          format.html { redirect_back fallback_location: root_path, notice: 'setting deactivated.' }
        else
          format.html { render :new }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @choice = @setting.choices.build
      respond_to do |f|
        f.js { render 'edit', locals: { setting: @setting }}
      end
    end


    def create
      @setting = Setting.new(setting_params)
      respond_to do |format|
        if @setting.save
          format.js { redirect_to [:admin, @setting.platform], notice: "setting created"}
        else
          format.html { render :new }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @setting.update(setting_params)
          format.html { redirect_back fallback_location: root_path, notice: 'setting activated.' }
          format.js { render 'update', locals: { setting: @setting }}
          format.json { render :show, status: :ok, location: @setting }
        else
          format.html { render :edit }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @setting.destroy
      respond_to do |format|
        format.html { redirect_to @setting.platform, notice: 'Setting was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def set_setting
        @setting = Setting.find(params[:id])
      end

      def setting_params
        params.require(:setting).permit(:sorted, :page, :platform_id, :setting_id, :vector_id, :name, :text, :description, :fqurl, :edit_url, :url, :recommended_choice, :row_order_position, :they_say, :we_say, :browser_name, :browser_version, choices_attributes: [ :name, :value, :they_say, :we_say] )
      end
  end
end