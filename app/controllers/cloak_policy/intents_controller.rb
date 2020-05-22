require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class IntentsController < ApplicationController
    before_action :set_intent, only: [:show, :edit, :update, :destroy]

    def index
      @intents = Intent.all
    end

    def show
    end

    def new
      @intent = Intent.new
    end

    def edit
    end

    def create
      @intent = Intent.new(intent_params)
      respond_to do |format|
        if @intent.save
          format.js { redirect_back fallback_location: @intent.vector, notice:  'Intent was successfully created.' }
        end 
      end
    end

    def update

      respond_to do |format|
        if @intent.update(intent_params)
          format.js { render :edit, notice: 'Platform was successfully created.' }
        else
          render :edit
        end
      end
    end

    def destroy
      @intent.destroy
      redirect_to @intent.vector, notice: 'Intent was successfully destroyed.'
    end

    private
      def set_intent
        @intent = Intent.find(params[:id])
      end

      def intent_params
        
        params.require(:intent).permit(:name, :description, :weight, :vector_id)
      end
  end
end
