module CloakPolicy
  class ChoicesController < ApplicationControllerr
    before_action :set_choice, only: [:show, :edit, :update, :destroy, :activate, :deactivate]

    def activate
      respond_to do |format|
        if @choice.activate!
          format.html { redirect_back fallback_location: root_path, notice: 'choice activated.' }
          format.js { render 'update', locals: { choice: @choice }}

        else
          format.html { render :new }
          format.json { render json: @choice.errors, status: :unprocessable_entity }
        end
      end
    end

    def deactivate
      respond_to do |format|
        if @choice.deactivate!
          format.html { redirect_back fallback_location: root_path, notice: 'choice deactivated.' }
          format.js { render 'update', locals: { choice: @choice }}
        else
          format.html { render :new }
          format.json { render json: @choice.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
      respond_to do |f|
        f.js { render 'settings/show', locals: { setting: @choice.setting }}
      end
    end

    def new
      @setting = Setting.find(params["setting_id"])
      @choice = @setting.choices.build
      respond_to do |f|
        f.js { render 'new', locals: { choice: @choice }}
      end
    end

    def edit
      respond_to do |f|
        f.js { render 'edit', locals: { choice: @choice }}
      end
    end

    def create
      @choice = Choice.new(choice_params)
      respond_to do |format|
        if @choice.save
          format.html { redirect_to @choice, notice: 'Choice was successfully created.' }
          format.js { render 'create', locals: { choice: @choice }}

          format.json { render :show, status: :created, location: @choice }
        else
          format.html { render :new }
          format.json { render json: @choice.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @choice.update(choice_params)
          format.js { render 'update', locals: { choice: @choice }}
        else
          format.html { render :edit }
          format.json { render json: @choice.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @choice.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: recommendations_path, notice: 'Choice destroyed.'  }
        format.json { head :no_content }
      end
    end

    private

      def set_choice
        @choice = Choice.find(params[:id])
      end

      def choice_params
        params.require(:choice).permit(:name, :value, :setting_id, :description, :dom_locator, :edit_url, :we_say, :they_say, :fqurl)
      end
  end
end