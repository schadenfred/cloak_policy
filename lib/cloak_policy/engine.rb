module CloakPolicy
  class Engine < ::Rails::Engine
    isolate_namespace CloakPolicy

    config.generators do |g| 
      g.template_engine :haml
    end
  end
end
