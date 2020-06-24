module CloakPolicy
  class Api::V1::ChoiceSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :value, :we_say, :they_say, :weight, :description 

    belongs_to :setting
    
    attribute :description do |object|
      object.we_say 
    end
  end
end
