module CloakPolicy
  class PreferencesUseCase < ApplicationRecord

    belongs_to :preference
    belongs_to :use_case
  end
end
