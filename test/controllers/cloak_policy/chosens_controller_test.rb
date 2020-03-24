# require 'test_helper'

# module CloakPolicy
#   class ChosensControllerTest < ActionDispatch::IntegrationTest
#     include Engine.routes.url_helpers

#     setup do
#       @chosen = cloak_policy_chosens(:one)
#     end

#     test "should get index" do
#       get chosens_url
#       assert_response :success
#     end

#     test "should get new" do
#       get new_chosen_url
#       assert_response :success
#     end

#     test "should create chosen" do
#       assert_difference('Chosen.count') do
#         post chosens_url, params: { chosen: { choice_id: @chosen.choice_id, recommendable: @chosen.recommendable, recommendation_id: @chosen.recommendation_id, setting_id: @chosen.setting_id } }
#       end

#       assert_redirected_to chosen_url(Chosen.last)
#     end

#     test "should show chosen" do
#       get chosen_url(@chosen)
#       assert_response :success
#     end

#     test "should get edit" do
#       get edit_chosen_url(@chosen)
#       assert_response :success
#     end

#     test "should update chosen" do
#       patch chosen_url(@chosen), params: { chosen: { choice_id: @chosen.choice_id, recommendable: @chosen.recommendable, recommendation_id: @chosen.recommendation_id, setting_id: @chosen.setting_id } }
#       assert_redirected_to chosen_url(@chosen)
#     end

#     test "should destroy chosen" do
#       assert_difference('Chosen.count', -1) do
#         delete chosen_url(@chosen)
#       end

#       assert_redirected_to chosens_url
#     end
#   end
# end
