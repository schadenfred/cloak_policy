module CloakPolicy
  class PlatformsController < ApplicationControllerr
    before_action :set_platform, only: [:show, :edit, :update, :destroy]

    def index
      @platforms = Platform.all
    end

    def scoring
      @platforms = Platform.all
      @vector = Vector.new
    end

    def show
      @platforms = Platform.all
    end

    def new
      @platform = Platform.new
    end

    def edit
    end

    def create
      @platform = Platform.new(platform_params)
      respond_to do |format|
        if @platform.save
          format.html { redirect_to platforms_url, notice: 'Platform was successfully created.' }
        else
          format.json { render json: @platform.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @platform.update(platform_params)
          format.html { redirect_to platforms_url, notice: 'Platform was successfully created.' }
        else
          format.json { render json: @platform.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @platform.destroy
      respond_to do |format|
        format.html { redirect_to platforms_url, notice: 'Platform was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_platform
        @platform = Platform.find(params[:id])
      end

      def platform_params
        params.require(:platform).permit(:description, :icon, :fqdn, :domain, :platform_type, :name, :description, :platform_score, settings_attributes: [
        :id, :name, :fqurl, :they_say, :we_say, :page, :_destroy])

      end
  end
end