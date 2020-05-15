module CloakPolicy
  class Intent < ApplicationRecord
    belongs_to :intendable, polymorphic: true
  end
end
