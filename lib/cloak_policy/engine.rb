module CloakPolicy
  class Engine < ::Rails::Engine
    isolate_namespace CloakPolicy

    config.generators do |g|
      g.template_engine :haml
    end

    initializer "cloak_policy.assets.precompile" do |app|
      app.config.assets.precompile += %w( cloak_policy/application.js cloak_policy/application.css )
    end

  end
end
