require 'test_helper'

module CloakPolicy
  class Api::V1::ConfigurationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get show" do
      get api_v1_configurations_show_url
      assert_response :success
    end

  end
end
