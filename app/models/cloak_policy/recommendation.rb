class Recommendation < ApplicationRecord
  include Scorable
  include Recommendable

  has_many :chosens, dependent: :destroy
  has_many :choices, through: :chosens

  has_one :recommendations_use_case, dependent: :destroy
  has_one :use_case, through: :recommendations_use_case

  has_many :preferences, through: :use_case

  has_many :recommendations_platforms, dependent: :destroy
  has_many :platforms, through: :recommendations_platforms
  has_many :recommendations_settings, through: :platforms, source: :settings
  has_many :settings, through: :choices, class_name: "Setting"

  accepts_nested_attributes_for :chosens

  validates :name, presence: true

  def recommendable_platforms
    recommendations_platforms.select { |rs| rs.platform.recommendable == true}
  end

  def platforms_for(user_id)
    user = User.find(user_id)
    svcs = recommendable_platforms.select { |rs| rs.platform.id == user.free_platform_id}
    svcs
  end

  def recommended_choices
    selected = chosens.select &:platform_recommended?
    chosens.to_a.select(&:recommendable?).sort_by(&:position)
  end

  def recommended_choices_for(user_id)
    user = User.find(user_id)

    recommended = chosens.select(&:platform_recommended?)
    selected = recommended.select { |c| c.choice.setting.platform.eql?(user.free_platform) }
    selected.to_a.select(&:recommendable?).sort_by(&:position)
  end

  def profile
    use_case.profile || 'custom '
  end

  def selected_platforms
    default = Platform.where(name: "facebook")
    rs = platforms.where(recommendable: true)
    rs.empty? ? default : rs
  end

  def recommends?(platform)
    recommendables.include? platform
  end

  def launchable
    setting_ids = chosens.pluck(:setting_id)
    settings = Setting.find(setting_ids)
    platform_ids = settings.pluck(:platform_id)
    platforms.where(platform_ids.include? :id )
  end

  def clone_rec(options=nil)
    clone = dup
    clone.update(options)
    chosens.each do |chosen|
      clone.chosens.build(setting_id: chosen.setting_id, choice_id: chosen.choice_id, recommendable: chosen.recommendable)
    end
    recommendations_platforms.each do |rs|
      clone.recommendations_platforms.create!(platform_id: rs.platform.id)
    end
    clone
  end

  def choice_for(setting)
    chosen = chosens.where(setting_id: setting.id, recommendable: true).last
    chosen.nil? ? nil : chosen.choice
  end

  def recommend!(choice)
    setting_chosens = chosens.where(choice_id: choice.setting.choice_ids)
    setting_chosens.each { |sc| sc.update(recommendable: false) }
    chosens.find_or_create_by(
      choice_id: choice.id, setting_id: choice.setting.id).activate!
  end

  def scores_for(vector)
    array = []
    recommendations_platforms.each { |rs| array << rs.points_for(vector) }
    array
  end
end


