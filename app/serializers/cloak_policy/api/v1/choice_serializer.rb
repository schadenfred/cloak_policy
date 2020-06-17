module CloakPolicy
  class Api::V1::ChoiceSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :value, :we_say, :they_say, :weight

    belongs_to :setting
  end
end
