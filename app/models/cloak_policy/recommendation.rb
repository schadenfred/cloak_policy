module CloakPolicy
  class Recommendation < ApplicationRecord

    has_many :chosens
  end
end
