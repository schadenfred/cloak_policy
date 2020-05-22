module CloakPolicy
  class Intent < ApplicationRecord
    belongs_to :vector
  end
end
