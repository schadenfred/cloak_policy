# require 'test_helper'

# module CloakPolicy
#   class PreferencesUseCasesControllerTest < ActionDispatch::IntegrationTest
#     include Engine.routes.url_helpers

#     setup do
#       @preferences_use_case = cloak_policy_preferences_use_cases(:one)
#     end

#     test "should get index" do
#       get preferences_use_cases_url
#       assert_response :success
#     end

#     test "should get new" do
#       get new_preferences_use_case_url
#       assert_response :success
#     end

#     test "should create preferences_use_case" do
#       assert_difference('PreferencesUseCase.count') do
#         post preferences_use_cases_url, params: { preferences_use_case: { preferece_id: @preferences_use_case.preferece_id, use_case_id: @preferences_use_case.use_case_id } }
#       end

#       assert_redirected_to preferences_use_case_url(PreferencesUseCase.last)
#     end

#     test "should show preferences_use_case" do
#       get preferences_use_case_url(@preferences_use_case)
#       assert_response :success
#     end

#     test "should get edit" do
#       get edit_preferences_use_case_url(@preferences_use_case)
#       assert_response :success
#     end

#     test "should update preferences_use_case" do
#       patch preferences_use_case_url(@preferences_use_case), params: { preferences_use_case: { preferece_id: @preferences_use_case.preferece_id, use_case_id: @preferences_use_case.use_case_id } }
#       assert_redirected_to preferences_use_case_url(@preferences_use_case)
#     end

#     test "should destroy preferences_use_case" do
#       assert_difference('PreferencesUseCase.count', -1) do
#         delete preferences_use_case_url(@preferences_use_case)
#       end

#       assert_redirected_to preferences_use_cases_url
#     end
#   end
# end
