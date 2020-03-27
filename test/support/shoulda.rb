# frozen_string_literal: true
require "shoulda-context"
require "shoulda-matchers"
require "minitest/matchers_vaccine"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
