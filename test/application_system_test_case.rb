require "test_helper"
require "minitest/rails/capybara"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase

  include CloakPolicy::Engine.routes.url_helpers
  CloakPolicy::Engine.routes.default_url_options[:host] = "localhost:3000"

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  Capybara.server = :webrick

  register_spec_type(self) do |desc, *addl|
    addl.include? :system
  end

  def javascript
    Capybara.current_driver = :selenium_chrome_headless
  end

end
