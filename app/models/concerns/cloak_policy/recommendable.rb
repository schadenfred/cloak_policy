require 'active_support/concern'

module CloakPolicy::Recommendable

  extend ActiveSupport::Concern

  included do
    scope :recommendable, -> { where(recommendable: true) }

    def recommendables
      case self.class.to_s
      when 'CloakPolicy::Platform'
        settings.where(recommendable: true)
      when 'CloakPolicy::Setting'
        choices.where(recommendable: true)
      end
    end

    def recommendable?
      case self.class.to_s
      when 'CloakPolicy::Choice'
        self.setting.recommendable? && self["recommendable"]
      when 'CloakPolicy::Setting'
        self.platform.recommendable && self["recommendable"]
      when 'CloakPolicy::Platform'
        self["recommendable"]
      when 'CloakPolicy::Chosen'
        self.choice.recommendable? && self["recommendable"]
      end
    end

    def parent_recommendable?
      case self.class.to_s
      when 'CloakPolicy::Choice'
        self.setting.recommendable?
      when 'CloakPolicy::Setting'
        self.platform.recommendable?
      when 'CloakPolicy::Platform'
        true
      end
    end

    def sloppy?(record=nil)
      case self.class.to_s
      when 'CloakPolicy::Platform'
        platform_clean = self.settings.size.eql?(self.recommendables.size) ? true : false
        settings_clean = (self.settings.any? { |item| item.sloppy? }) ? false : true
        (platform_clean && settings_clean) ? false : true
      when 'CloakPolicy::Setting'
        choices_clean = self.choices.size.eql?(self.recommendables.size) ? true : false
        setting_recommendable = self.recommendable? ? true : false
        (choices_clean && setting_recommendable) ? false : true
      end
    end
  end

  def activate!
    update_attribute(:recommendable, true)
  end

  def deactivate!
    update_attribute(:recommendable, false)
  end
end