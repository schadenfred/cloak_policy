require 'active_support/concern'

module CloakPolicy
  module Advisable
    extend ActiveSupport::Concern

    included do

      def they_say

        case self.class.to_s
        when 'CloakPolicy::Platform'
          self["they_say"] ||= name
        when 'CloakPolicy::Setting'
          self["they_say"] ||= name
        when 'CloakPolicy::Choice'
          self["they_say"] ||= setting.they_say
        when 'CloakPolicy::Chosen'
          choice.they_say
        end
      end

      def we_say
        case self.class.to_s

        when 'CloakPolicy::Platform'
          self["we_say"] ||= they_say
        when 'CloakPolicy::Setting'
          self["we_say"] ||= they_say
        when 'CloakPolicy::Choice'
          self["we_say"] || they_say
        when 'CloakPolicy::Chosen'
          self["they_say"] ||= name
        end
      end
    end
  end
end