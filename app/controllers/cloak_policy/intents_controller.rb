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
      @vector = Vector.find(params[:vector_id])      
      @intent = @vector.intents.new
    end

    def edit
    end

    def create
      byebug
      @intent = Intent.new(intent_params)
      respond_to do |format|
        if @intent.save
          format.js { redirect_to @intent.vector, notice:  'Intent was successfully created.' }
        end 
      end
    end

    def update
      
      respond_to do |format|
        if @intent.update(intent_params)
          format.html { redirect_to @intent.vector, notice: 'Intent successfully updated.' }
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
