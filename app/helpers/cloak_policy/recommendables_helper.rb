module CloakPolicy
  module RecommendablesHelper

    def accordion_class(recommendable)
      recommendable.sloppy? ? 'text-white bg-info mb-3' : 'text-white bg-success mb-3'
    end

    def recommendable_status(record)
      record.recommendable? ? 'success' : 'info'
    end

    def recommendable_link_for(record)
      klass = record.class.name.demodulize.to_s.downcase
      case
      when !record.parent_recommendable?
        "inactive"
      when record.recommendable && record.parent_recommendable?
        action_link_for(record, "deactivate")
      when !record.recommendable && record.parent_recommendable?
        action_link_for(record, "activate")
      end
    end

    def action_link_for(rec, action)
      id = "#{rec.class.name.demodulize.downcase}#{action.capitalize}-#{rec.id}"
      params = { recommendable: {
          recommendable_id: rec.id, recommendable_class: rec.class.name.to_s } }
      case action
      when 'deactivate'
        path = recommendables_deactivate_path( params: params )
      when 'activate'
        path = recommendables_activate_path( params: params )
      end
      link_to action, path, id: id, method: :patch, remote: true
    end
  end
end
