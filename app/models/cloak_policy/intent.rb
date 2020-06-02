module CloakPolicy
  class Intent < ApplicationRecord
    belongs_to :vector

    def icon 
      "face"
    end
  end
end
