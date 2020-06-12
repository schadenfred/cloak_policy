module CloakPolicy
  class Api::V1::ChoiceSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :value, :we_say, :they_say

    belongs_to :setting
  end
end
