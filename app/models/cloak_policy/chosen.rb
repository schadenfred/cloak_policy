module CloakPolicy
  class Chosen < ApplicationRecord

    belongs_to :choice
    belongs_to :recommendation
  end
end
