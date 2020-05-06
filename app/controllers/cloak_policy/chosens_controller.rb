require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class ChosensController < ApplicationController
    before_action :set_chosen, only: [:show, :edit, :update, :destroy]

    # GET /chosens
    def index
      @chosens = Chosen.all
    end

    # GET /chosens/1
    def show
    end

    # GET /chosens/new
    def new
      @chosen = Chosen.new
    end

    # GET /chosens/1/edit
    def edit
    end

    # POST /chosens
    def create
      @chosen = Chosen.new(chosen_params)

      if @chosen.save
        redirect_to @chosen, notice: 'Chosen was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /chosens/1
    def update
      if @chosen.update(chosen_params)
        redirect_to @chosen, notice: 'Chosen was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /chosens/1
    def destroy
      @chosen.destroy
      redirect_to chosens_url, notice: 'Chosen was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chosen
        @chosen = Chosen.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def chosen_params
        params.require(:chosen).permit(:choice_id, :recommendation_id, :advice)
      end
  end
end
