module CloakPolicy
  class Api::V1::PlatformSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :fqdn, :description, :icon, :platform_type, :they_say, :we_say

    has_many :settings

  end
end
