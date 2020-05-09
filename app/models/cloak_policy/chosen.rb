module CloakPolicy
  class Chosen < ApplicationRecord

    belongs_to :choice
    belongs_to :recommendation

    def name 
      choice.name 
    end

    def value 
      choice.value 
    end
  end
end
