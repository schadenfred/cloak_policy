require 'active_support/concern'

module Advisable
  extend ActiveSupport::Concern

  included do

    def they_say
      case self.class.to_s
      when 'Platform'
        self["they_say"] ||= name
      when 'Setting'
        self["they_say"] ||= name
      when 'Choice'
        self["they_say"] ||= setting.they_say
      when 'Chosen'
        choice.they_say
      end
    end

    def we_say
      case self.class.to_s
      when 'Platform'
        self["we_say"] ||= they_say
      when 'Setting'
        self["we_say"] ||= they_say
      when 'Choice'
        self["we_say"] || they_say
      when 'Chosen'
        self["they_say"] ||= name
      end
    end
  end
end