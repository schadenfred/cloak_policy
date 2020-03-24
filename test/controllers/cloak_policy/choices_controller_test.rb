require 'test_helper'

module CloakPolicy
  class ChoicesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @choice = cloak_policy_choices(:one)
    end

    test "should get index" do
      get choices_url
      assert_response :success
    end

    test "should get new" do
      get new_choice_url
      assert_response :success
    end

    test "should create choice" do
      assert_difference('Choice.count') do
        post choices_url, params: { choice: { development_recommendation_id: @choice.development_recommendation_id, name: @choice.name, recommendable: @choice.recommendable, setting_id: @choice.setting_id, they_say: @choice.they_say, we_say: @choice.we_say } }
      end

      assert_redirected_to choice_url(Choice.last)
    end

    test "should show choice" do
      get choice_url(@choice)
      assert_response :success
    end

    test "should get edit" do
      get edit_choice_url(@choice)
      assert_response :success
    end

    test "should update choice" do
      patch choice_url(@choice), params: { choice: { development_recommendation_id: @choice.development_recommendation_id, name: @choice.name, recommendable: @choice.recommendable, setting_id: @choice.setting_id, they_say: @choice.they_say, we_say: @choice.we_say } }
      assert_redirected_to choice_url(@choice)
    end

    test "should destroy choice" do
      assert_difference('Choice.count', -1) do
        delete choice_url(@choice)
      end

      assert_redirected_to choices_url
    end
  end
end
