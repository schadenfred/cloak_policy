module CloakPolicy
  class Engine < ::Rails::Engine
    isolate_namespace CloakPolicy

    config.generators do |g|
      g.template_engine :haml
    end

    initializer "webpacker.proxy" do |app|
      insert_middleware = begin
                          CloakPolicy.webpacker.config.dev_server.present?
                        rescue
                          nil
                        end
      next unless insert_middleware

      app.middleware.insert_before(
        0, Webpacker::DevServerProxy, # "Webpacker::DevServerProxy" if Rails version < 5
        ssl_verify_none: true,
        webpacker: CloakPolicy.webpacker
      )
    end
  end
end
