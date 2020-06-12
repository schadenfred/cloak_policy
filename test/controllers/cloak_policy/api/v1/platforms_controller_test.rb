require 'test_helper'

module CloakPolicy
  class Api::V1::PlatformsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get api_v1_platforms_index_url
      assert_response :success
    end

    test "should get show" do
      get api_v1_platforms_show_url
      assert_response :success
    end

  end
end
