module CloakPolicy
  class Setting < ApplicationRecord

    include Advisable
    include RankedModel
    include Recommendable
    include Scorable

    belongs_to :platform, optional: true

    has_many :choices, dependent: :destroy

    accepts_nested_attributes_for :choices, allow_destroy: true, update_only: true

    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false, scope: :platform_id }

    ranks :row_order, with_same: [:platform_id]
    scope :active,   -> { select { |s| s.recommendable? == true } }
    scope :inactive, -> { select { |s| s.recommendable? == false } }

    def icon
      self["icon"] || platform.icon
    end

    def inactive_choices
      choices.select { |c| c.recommendable? == false }
    end

    def has_inactive_choices?
      inactive_choices.size.eql? 0
    end

    def recommendable_choices
      self.choices.where(recommendable: true)
    end

    def indices_for(vector)
      array = []
      choices.each { |c| array << c.weight_for(vector.downcase.to_s)}
      array
    end
  end


end
