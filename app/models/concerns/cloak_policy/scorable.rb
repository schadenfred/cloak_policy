require 'active_support/concern'

module CloakPolicy

  module Scorable
    extend ActiveSupport::Concern

    included do
      has_many :scores, as: :scorable, dependent: :destroy
      has_many :vectors, through: :scores, as: :scorable
    end

    def weight_for(vector_id)
      array = scores.where(vector_id: vector_id)
      array.empty? ? 100 : array.first.weight
    end

    def point_total_for(vector)
      total = 0
      case self.class.to_s

      when "Setting"
        platform.settings.each do |setting|
          total += setting.weight_for(:vector)
        end
        total
      end
    end

    def share_for(vector, platform=nil)
      case self.class.to_s
      when "Recommendation"
        rs = recommendations_platforms.find_by(platform_id: platform.id)
        (rs.weight_for(vector).to_f / point_total_for(vector).to_f * 100).round
      when "Setting"
        (weight_for(vector).to_f / point_total_for(vector).to_f * 100).round
      end
    end
  end
end