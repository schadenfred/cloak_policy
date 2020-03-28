module CloakPolicy

  module PlatformsHelper

    def link_to_platform(platform)
      classes = ['nav-link']
      classes << 'active' if platform.eql? @platform
      link_to material_icon(platform.icon, "2x"), platform, class: classes
    end
  end
end