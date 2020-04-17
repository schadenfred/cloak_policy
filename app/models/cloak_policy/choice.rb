module CloakPolicy
  class Choice < ApplicationRecord

    include Advisable
    include Recommendable
    include Scorable

    belongs_to :setting

    validates :setting, presence: true
    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false, scope: :setting_id }

    scope :by_setting_position, -> {order('settings.position').includes(:setting)}

    scope :inactive, -> { select { |s| s.recommendable? == false } }

    def platform
      setting.platform
    end

    def value
      self["value"] || name
    end

    def impact_for(vector)
      score = scores.find_by(vector_id: vector.id)
      score.impact unless score.nil?
    end

    def weight
      hash = { }
      Vector.all.each do |v|
        hash[v.name.downcase] = weight_for(v)
      end
      hash
    end

    def impacts
      hash = { }
      Vector.all.each do |v|
        hash[v.name.downcase] = impact_for(v)
      end
      hash
    end
  end
end
