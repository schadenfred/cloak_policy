require 'active_support/concern'
module CloakPolicy

module Scorable
  extend ActiveSupport::Concern

  included do
    has_many :scores, as: :scorable, dependent: :destroy
    has_many :vectors, through: :scores, as: :scorable
  end

  def points_for(vector)
    unless vector.class.name.eql?("Vector")
      vector = Vector.find_by(name: vector.to_s.capitalize)
    end
    case self.class.to_s
    when "Chosen"
      rec = recommendation
      svc = choice.setting.platform
      rs = RecommendationsPlatform.where(
        recommendation_id: recommendation.id,
        platform_id: svc.id).first

      rsp = rs.points_for(vector)
      sp = choice.setting.points_for(vector)
      cp = choice.points_for(vector)
      score = (rsp.to_f * (sp.to_f / 100) * (cp.to_f / 100 )).round
      return score
    end

    if scores.empty?
      return
    end
    score = scores.where(vector_id: vector.id).first
    score.nil? ? nil : score.points
  end

  def point_total_for(vector)
    total = 0
    case self.class.to_s
    when "Recommendation"
      recommendations_platforms.each do |rs|
        total += rs.points_for(vector)
      end
      total
    when "Setting"
      platform.settings.each do |setting|
        total += setting.points_for(:vector)
      end
      total
    end
  end

  def share_for(vector, platform=nil)
    case self.class.to_s
    when "Recommendation"
      rs = recommendations_platforms.find_by(platform_id: platform.id)
      (rs.points_for(vector).to_f / point_total_for(vector).to_f * 100).round
    when "Setting"
      (points_for(vector).to_f / point_total_for(vector).to_f * 100).round
    end
  end
end
end