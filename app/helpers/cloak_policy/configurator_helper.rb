module ConfiguratorHelper

  def profiles
    hash = {}
    Profile.all.each do |profile|
      hash[profile.name] = profile.description
    end
    hash
  end

  def use_cases
    hash = {}
    UseCase.all.each do |use_case|
      hash[use_case.name] = use_case.description
    end
    hash
  end

  def help_for(resource)
    "<div class='card-footer'>
      <div class='card text-white bg-info mb-3'>
        <div class='card-header'>
          #{I18n.t(resource + '.header')}
        </div>
        <div class='card-body'>
          #{I18n.t(resource + '.body')}
        </div>
      </div>
    </div>".html_safe
  end

  def launch_btn(rec_id, opts={})
    text = opts[:text] || "Launch"
    cloned = (opts[:cloned] == true) ? "data-cloned='true'" : nil
    svc = opts[:svc_id].nil? ? nil : "data-svc-id='#{opts[:svc_id]}'"
    data = "<div class='btn btn-primary #{opts[:html_class]} launch-rec' \
    data-extension-id='#{Extension::ID}' data-rec-id='#{rec_id}' #{svc} \
      #{cloned}>#{text}</div>".html_safe
  end

  def analyze_btn(opts={text: 'Analyze'})
    link_to opts[:text], analyze_path, class: 'btn btn-primary btn-block btn-lg analyzeAcceptedRec', remote: true
  end

  def uninstall_reasons
    array = [
      "Slows down my computer",
      "Can't customize well enough",
      "Too expensive",
      "Doesn't work for Instagram",
      "Doesn't work for Pinterest",
      "Doesn't work for my favorite sites"

    ]
    array.map.with_index { |k,v| [v,k] }.to_h
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
