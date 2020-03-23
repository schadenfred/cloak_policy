require 'active_support/concern'

module Recommendable

  extend ActiveSupport::Concern

  included do
    scope :recommendable, -> { where(recommendable: true) }

    def recommendables
      case self.class.to_s
      when 'Recommendation'
        platforms.where(recommendable: true)
      when 'Platform'
        settings.where(recommendable: true)
      when 'Setting'
        choices.where(recommendable: true)
      end
    end

    def recommendable?
      case self.class.to_s
      when 'Choice'
        self.setting.recommendable? && self["recommendable"]
      when 'Setting'
        self.platform.recommendable && self["recommendable"]
      when 'Platform'
        self["recommendable"]
      when 'Chosen'
        self.choice.recommendable? && self["recommendable"]
      end
    end

    def parent_recommendable?
      case self.class.to_s
      when 'Choice'
        self.setting.recommendable?
      when 'Setting'
        self.platform.recommendable?
      end
    end

    def sloppy?(record=nil)
      case self.class.to_s
      when 'Platform'
        platform_clean = self.settings.size.eql?(self.recommendables.size) ? true : false
        settings_clean = (self.settings.any? { |item| item.sloppy? }) ? false : true
        (platform_clean && settings_clean) ? false : true
      when 'Setting'
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