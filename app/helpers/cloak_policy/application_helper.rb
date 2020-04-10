
module CloakPolicy

  module ApplicationHelper

    def active_link_to(name, url)
      link_to name, url, class: "nav-link #{'disabled' if current_page?(url)}"
    end

    def title
      base_title = "Cloak"
      page = controller_name
      title = base_title + " | " + page.humanize
      title
    end

    def fill_murray(w, h=nil)
      h = h || w
      if Rails.env.developmnt?
        image_tag("https://www.fillmurray.com/g/#{w}/#{h}", class: 'rounded-lg')
      else
        image_tag("placeholders/#{w}x#{h}.jpg", class: 'rounded-lg')
      end
    end

    def subscription_plan
      case
      when current_user.subscribed?
        current_user.subscription.plan.name
      when current_user.has_role?(:site_admin)
        "N / A"
      when
        "Not subscribed"
      end
    end

    def link_to_clone(original)
      link_to( "clone", clone_path( cloneable: {
          cloneable_type: original.class.name,
          cloneable_id: original.id}), method: :post)
    end

    def link_to_destroy(object)
      link_to 'Destroy', object, method: :delete, data: { confirm: 'Are you sure?' }
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

    def active_for_dev(tabname)
      case
      when Rails.env.eql?("development")
        if tabname.downcase.eql?("scoring")
          # 'active show'
        end
      when tabname.downcase.eql?("manage")
        'active show'
      end
    end

    def category_types
      array =  []
      %w(profile use_case category preference).each do |ct|
        array << [ct.titleize, ct]
      end
      array
    end

    def step_status(every_step)
      case
      when every_step == step
        'btn-success'
      when past_step?(every_step)
        'btn-outline-success'
      when future_step?(every_step)
        'btn-outline-info'
      end
    end

    def step_icon(every_step)
      case
      when every_step == step
        'mdi-plus'
      when past_step?(every_step)
        'mdi-check'
      when future_step?(every_step)
        'mdi-minus'
      end
    end
  end

end