module CloakPolicy
  class Api::V1::VectorSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :icon, :description 

    belongs_to :parent, if: Proc.new { |record| record.parent }
    has_many :intents, if: Proc.new { |record| record.parent }
    has_many :subvectors, if: Proc.new { |record| record.subvectors.any? }
    has_many :scored_settings, if: Proc.new { |record| record.parent }
  end
end
