require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class PlatformsController < ApplicationController
    before_action :set_platform, only: [:show, :edit, :update, :destroy]

    # GET /platforms
    def index
      @platforms = Platform.all
    end

    # GET /platforms/1
    def show
    end

    # GET /platforms/new
    def new
      @platform = Platform.new
    end

    # GET /platforms/1/edit
    def edit
    end

    # POST /platforms
    def create
      @platform = Platform.new(platform_params)

      if @platform.save
        redirect_to @platform, notice: 'Platform was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /platforms/1
    def update
      if @platform.update(platform_params)
        redirect_to @platform, notice: 'Platform was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /platforms/1
    def destroy
      @platform.destroy
      redirect_to platforms_url, notice: 'Platform was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_platform
        @platform = Platform.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def platform_params
        params.require(:platform).permit(:name, :fqdn, :description, :icon, :platform_type, :they_say, :we_say, :recommendable)
      end
  end
end
