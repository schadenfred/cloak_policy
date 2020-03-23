class PreferencesRecommendation < ApplicationRecord

  belongs_to :preference
  belongs_to :recommendation
end
