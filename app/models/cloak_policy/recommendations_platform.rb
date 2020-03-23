class RecommendationsPlatform < ApplicationRecord

  include Scorable

  belongs_to :recommendation
  belongs_to :platform
end