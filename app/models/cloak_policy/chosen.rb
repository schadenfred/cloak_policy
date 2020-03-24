module CloakPolicy
  class Chosen < ApplicationRecord

    include Advisable
    include Recommendable
    include Scorable

    belongs_to :choice
    belongs_to :recommendation
    belongs_to :setting

    validates :choice, :recommendation, :setting, presence: true
    validates_uniqueness_of :choice_id, scope: :recommendation_id

    scope :by_position, -> { order('position') }

    def platform_recommended?
      recommendation.platform_ids.include? choice.setting.platform.id
    end

    def advice
      self["advice"] || choice.we_say
    end

    def platform
      choice.setting.platform
    end

    def position
      choice.setting.row_order_rank
    end

    def siblings
      choice.setting.recommendables - [choice]
    end

    def deltas
      impact = []
      siblings.each do |delta|
        hash = { }
        hash[:choice_id] = delta.id
        hash[:choice_name] = delta.name
        hash["points"] = {}
        hash["impact"] = {}
        Vector.all.each do |vector|
          hash["impact"][vector.name.downcase] = delta_for(delta, vector)
          hash["points"][vector.name.downcase] = delta_points_for(delta, vector)
        end
        impact << hash
      end
      impact
    end


    def delta_points_for(choice, vector)
      points = recommendation.recommendations_platforms.find_by(platform_id: choice.setting.platform_id).points_for(vector)
      weight = choice.setting.points_for(vector)
      index = choice.points_for(vector)
      (points * weight * index) / (10000)
    end

    def delta_for(choice, vector)
      rs = RecommendationsPlatform.where(recommendation_id: recommendation.id, platform_id: choice.setting.platform.id).first
      platform_points = rs.points_for(vector)

      setting_points =  choice.setting.points_for(vector) * platform_points / 100
      delta = self.choice.points_for(vector) - choice.points_for(vector)
      points = delta * setting_points / 100
      case
      when points < 0
        "Reduces your #{vector.name.downcase} by #{points.abs} points."
      when points == 0
        "Not a big difference."
      when points > 0
        "Improves your #{vector.name.downcase} by #{points.abs} points."
      end
    end
  end

end
