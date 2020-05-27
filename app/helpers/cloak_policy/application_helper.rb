
module CloakPolicy

  module ApplicationHelper

    def active_link_to(name, url)
      link_to name, url, class: "nav-link #{'disabled' if current_page?(url)}"
    end

    def flash_class(level)
      case level
      when :notice then "alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
      end
    end

    def material_icon(icon=nil, size=nil, color=nil)
      icon = icon.blank? ? 'album' : icon
      size = size.nil? ? nil : " mdi-hc-#{size}"
      color = color.nil? ? nil : " mdc-text-#{color}"
      "<i class='icon mdi mdi-#{icon}#{size}#{color}'></i>".html_safe
    end

    def markdown(text)
      renderer = Redcarpet::Render::HTML
      markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      markdown.render(text).html_safe
    end
  end
end