module CloakPolicy
  class Api::V1::IntentSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :description, :weight

    belongs_to :vector
  end
end
