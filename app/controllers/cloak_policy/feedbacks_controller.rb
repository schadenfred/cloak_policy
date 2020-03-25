module CloakPolicy
  class FeedbacksController < ApplicationControllerr
    before_action :set_feedback, only: [:destroy]
    before_action :authenticate_user!, :except => [:create]

    def index
      @feedbacks = Feedback.all
    end

    def create
      @feedback = Feedback.new(feedback_params)

      respond_to do |format|
        if @feedback.save
          format.html { redirect_to root_url, notice: 'Thanks! Feedback was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    def destroy
      @feedback.destroy
      respond_to do |format|
        format.html { redirect_to admin_feedbacks_url, notice: 'Feedback was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_feedback
        @feedback = Feedback.find(params[:id])
      end

      def feedback_params
        params.require(:feedback).permit(:content, reasons: [])
      end
  end
end