module CloakPolicy
  class Intention < ApplicationRecord
    belongs_to :intendable, polymorphic: true
    belongs_to :intent
  end
end
