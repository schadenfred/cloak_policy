module CloakPolicy
  module RecommendablesHelper

    def recommendable_status(record)
      record.recommendable? ? 'success' : 'warning'
    end

    def recommendable_link_for(record)
      klass = record.class.name.demodulize.to_s.downcase

      case
      when !record.parent_recommendable?
        "\"inactive\"".html_safe
      when record.recommendable && record.parent_recommendable?
        action_link_for(record, "deactivate")
      when !record.recommendable && record.parent_recommendable?
        action_link_for(record, "activate")
      end
    end

    def action_link_for(record, action)
      link_to action, eval("recommendables_#{action}_path(
        params: {
          recommendable: {
            recommendable_id: #{record.id},
            recommendable_class: #{record.class.name.to_s }
          }
        }
      )"), class: "btn btn-#{recommendable_status(record)} btn-sm btn-block text-white", method: :patch, remote: true
    end
  end
end
