require 'active_support/concern'

module CloakPolicy

  module Scorable
    extend ActiveSupport::Concern

    included do
      has_many :scores, as: :scorable, dependent: :destroy
      has_many :vectors, through: :scores, as: :scorable
    end

    def weight_for(vector)
      unless vector.class.name.eql?("CloakPolicy::Vector")
        vector = Vector.find_by(name: vector.to_s.capitalize)
      end
      score = scores.where(vector_id: vector.id).first
      score.nil? ? 100 : score.weight
    end

    def point_total_for(vector)
      total = 0
      case self.class.to_s
      when "Recommendation"
        recommendations_platforms.each do |rs|
          total += rs.weight_for(vector)
        end
        total
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