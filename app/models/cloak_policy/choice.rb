class Choice < ApplicationRecord

  include Advisable
  include Recommendable
  include Scorable

  belongs_to :setting
  belongs_to :development_recommendation,
              class_name: "Recommendation", optional: true

  has_many :chosens, dependent: :destroy
  has_many :recommendations, through: :chosens

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
      hash[v.name.downcase] = points_for(v)
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

  def create_development_recommendation
    rec_name = "Isolation: #{setting.name} > #{name}"
    recommendation = Recommendation.create(name: rec_name)
    recommendation.chosens.create(choice_id: id, setting_id: setting.id)
    update(development_recommendation_id: recommendation.id)
    recommendation.recommendations_platforms.create(platform_id: setting.platform.id)
  end
end
