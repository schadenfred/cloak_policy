module CloakPolicy
  class Recommendation < ApplicationRecord

    has_many :chosens
    has_many :choices, through: :chosens
    has_many :intentions, as: :intendable, dependent: :destroy
    has_many :intents, through: :intentions

    
  end
end
