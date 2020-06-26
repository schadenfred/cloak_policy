module CloakPolicy
  class Api::V1::RecommendationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name 

    has_many :choices
    has_many :intents
  end
end

