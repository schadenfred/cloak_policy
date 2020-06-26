module CloakPolicy
  class Intent < ApplicationRecord
    belongs_to :vector
    has_many :intentions

    def icon 
      "face"
    end
  end
end
