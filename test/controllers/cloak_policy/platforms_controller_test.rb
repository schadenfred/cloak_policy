require 'test_helper'

module CloakPolicy
  class PlatformsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers


    setup do
      @platform = cloak_policy_platforms(:facebook)
      # @platform = platforms(:facebook)
    end

    test "should get index" do
      get platforms_url
      assert_response :success
    end

    # test "should get new" do
    #   get new_platform_url
    #   assert_response :success
    # end

    # test "should create platform" do
    #   assert_difference('Platform.count') do
    #     post platforms_url, params: { platform: { description: @platform.description, fqdn: @platform.fqdn, icon: @platform.icon, name: @platform.name, platform_type: @platform.platform_type, recommendable: @platform.recommendable, they_say: @platform.they_say, we_say: @platform.we_say } }
    #   end

    #   assert_redirected_to platform_url(Platform.last)
    # end

    # test "should show platform" do
    #   get platform_url(@platform)
    #   assert_response :success
    # end

    # test "should get edit" do
    #   get edit_platform_url(@platform)
    #   assert_response :success
    # end

    # test "should update platform" do
    #   patch platform_url(@platform), params: { platform: { description: @platform.description, fqdn: @platform.fqdn, icon: @platform.icon, name: @platform.name, platform_type: @platform.platform_type, recommendable: @platform.recommendable, they_say: @platform.they_say, we_say: @platform.we_say } }
    #   assert_redirected_to platform_url(@platform)
    # end

    # test "should destroy platform" do
    #   assert_difference('Platform.count', -1) do
    #     delete platform_url(@platform)
    #   end

    #   assert_redirected_to platforms_url
    # end
  end
end
