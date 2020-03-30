
module CloakPolicy

  module ApplicationHelper


    def active_link_to(name, url)
      link_to name, url, class: "nav-link #{'active' if current_page?(url)}"
    end

    def title
      base_title = "Cloak"
      page = controller_name
      title = base_title + " | " + page.humanize
      title
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

    def extension_install_path
      "https://chrome.google.com/webstore/detail/recall-privacy-extension/ioieoedgkhlfcolmeglbioooehgmdjje"
    end

    def call_to_action
      array = []
      controller = controller_name
      case
      when controller_name.eql?("configurator")
        array << "Configure Recall: #{step.to_s.humanize.titleize}"
      when controller_name.eql?("services")
        case
        when action_name.eql?('show')
          array << "Admin: Manage settings for #{@service.name}"
        end
      when controller_name.eql?("scores")
      when controller_name.eql?("pricing")
        array[0] = nil


      when %w(extension_errors dashboard scores).include?(controller)
        array = []
      when action_name.eql?("index")
      when action_name.eql?('show') && controller_name.eql?("recommendations_services")
        array << " | "recommendables_activate_path
        array << @recommendation.name
      # when action_name.eql?('show')
      #   array << " | "
      #   array << params["controller"].classify.constantize.find(params["id"]).name
      when
        array << " | "
        array << action_name.titleize
      end
      array.join.html_safe
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

    def icon_color(recommendable)
      recommendable.sloppy? ? 'amber' : 'green'
    end

    def accordion_class(recommendable)
      recommendable.sloppy? ? 'text-white bg-info mb-3' : 'text-white bg-success mb-3'
    end

    def material_icon(name=nil, size=nil, color=nil)
      name = name.nil? ? 'album' : name
      size = size.nil? ? nil : " mdi-hc-#{size}"
      color = color.nil? ? nil : " mdc-text-#{color}"
      "<i class='icon mdi mdi-#{name}#{size}#{color}'></i>".html_safe
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