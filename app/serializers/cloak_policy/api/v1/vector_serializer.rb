module CloakPolicy
  class Api::V1::VectorSerializer
    include FastJsonapi::ObjectSerializer

    attributes :name, :icon, :description 

    belongs_to :parent, if: Proc.new { |record| record.parent }
    has_many :intents, if: Proc.new { |record| record.intents.any? }
    has_many :subvectors, record_type: :vector, if: Proc.new { |record| record.subvectors.any? }
    has_many :scored_settings, record_type: :setting, if: Proc.new { |record| record.scored_settings.any? }
  end
end
