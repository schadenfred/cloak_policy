module CloakPolicy
  class Recommendation < ApplicationRecord

    has_many :chosens
    has_many :choices, through: :chosens

    
  end
end
