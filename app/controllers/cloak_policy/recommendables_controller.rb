require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class RecommendablesController < ApplicationController

    before_action :set_recommendable

    def activate
      respond_to do |format|
        if @recommendable.activate!
          format.js { render @js_action, locals: { recommendable: @recommendable }}

          format.html { redirect_back fallback_location: platforms_path, notice: "#{@klass} activated." }
        else
          format.html { redirect_back fallback_location: platforms_path, alert: "Not activated." }
        end
      end
    end

    def deactivate
      respond_to do |format|
        if @recommendable.deactivate!
          format.js { render @js_action, locals: { recommendable: @recommendable }}
        else
          format.html { redirect_back fallback_location: platforms_path, alert: "Not deactivated." }
        end
      end
    end

    private

    def recommendable_params
      params.require(:recommendable).permit(:recommendable_class, :recommendable_id)
    end

    def set_recommendable
      @klass = recommendable_params[:recommendable_class].classify
      @recommendable = @klass.constantize.find(recommendable_params[:recommendable_id])
      @js_action = "update_#{@recommendable.class.name.demodulize.downcase}"
    end
  end
end
