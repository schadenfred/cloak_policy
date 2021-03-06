module CloakPolicy
  class Platform < ApplicationRecord

    include Advisable
    include Recommendable
    include Scorable

    has_many :settings, dependent: :destroy

    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false }

    accepts_nested_attributes_for :settings, allow_destroy: true

    default_scope { order(:name) }

    def choices_for(recommendation)
      recommendation.choices.where(:setting => recommendables)
    end

    def vectors 
      CloakPolicy::Vector.top_level
    end

    def weights_for(vector)
      array = []
      settings.each { |s| array << (s.weight_for(vector) || "null")}
      array
    end

    def chart_data(vector)
      { labels: settings.pluck(:name),
        points: weights_for(vector) }
    end
  end

end
