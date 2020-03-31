module CloakPolicy

  module ActivationHelper

#     def activation_link_for(record)
#       klass = record.class.name.demodulize.to_s.downcase

#       case
#       when !record.parent_recommendable?
#         "\"inactive\"".html_safe
#       when record.recommendable && record.parent_recommendable?
#         action_link_for(klass, "deactivate")
#       when !record.recommendable && record.parent_recommendable?
#         action_link_for(klass, "activate")
#       end
#     end

#     def action_link_for(record, action)
#       "link_to '#{action}', #{action}_#{record}_path(#{record}), method: :patch, remote: true".html_safe
#     end

  end
end