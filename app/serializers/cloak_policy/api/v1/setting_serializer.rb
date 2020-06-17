module CloakPolicy
  class Api::V1::SettingSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :edit_url, :row_order, :they_say, :we_say, :page

    belongs_to :platform

    has_many :choices
  end
end
