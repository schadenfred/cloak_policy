module CloakPolicy
  class ClonesController < ApplicationControllerr
    before_action :set_cloneable, only: :clone

    def clone
      case @cloneable.class.name.to_s
      when "Recommendation"
        clone = @cloneable.clone_rec(name: ("Clone of " + @cloneable.name))
      when "Choice"
        clone = @cloneable.create_development_recommendation
      end

      respond_to do |format|

        if clone.save
          format.html { redirect_back fallback_location: admin_recommendations_path, notice: 'Clone was successfully created.' }

          format.json { render :show, status: :created, location: @setting }
        else
          format.html { redirect_to recommendations_path, notice: "Clone already exists." }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end

    private

      def set_cloneable
        klass = cloneable_params["cloneable_type"].classify.constantize
        @cloneable = klass.find(cloneable_params[:cloneable_id])
      end

      def cloneable_params
        params.require(:cloneable).permit(:cloneable_type, :cloneable_id)
      end
  end
end