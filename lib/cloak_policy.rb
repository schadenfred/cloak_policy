require "cloak_policy/engine"
require "haml-rails"
require "sass-rails"
require "bootstrap"
require "jquery-rails"
require "jquery-ui-rails"
require "shoulda-context"
require "shoulda-matchers"
require "ranked-model"
require "chart-js-rails"
require "webpacker"

require "turbolinks"

module CloakPolicy
  ROOT_PATH = Pathname.new(File.join(__dir__, ".."))

  class << self
    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: Rails.root,
        config_path: ROOT_PATH.join("config/webpacker.yml")
      )
    end
  end

end
