# require "application_system_test_case"

# module CloakPolicy
#   class RecommendationsTest < ApplicationSystemTestCase
#     setup do
#       @recommendation = cloak_policy_recommendations(:one)
#     end

#     test "visiting the index" do
#       visit recommendations_url
#       assert_selector "h1", text: "Recommendations"
#     end

#     test "creating a Recommendation" do
#       visit recommendations_url
#       click_on "New Recommendation"

#       fill_in "Description", with: @recommendation.description
#       fill_in "Name", with: @recommendation.name
#       fill_in "Recommender", with: @recommendation.recommender_id
#       click_on "Create Recommendation"

#       assert_text "Recommendation was successfully created"
#       click_on "Back"
#     end

#     test "updating a Recommendation" do
#       visit recommendations_url
#       click_on "Edit", match: :first

#       fill_in "Description", with: @recommendation.description
#       fill_in "Name", with: @recommendation.name
#       fill_in "Recommender", with: @recommendation.recommender_id
#       click_on "Update Recommendation"

#       assert_text "Recommendation was successfully updated"
#       click_on "Back"
#     end

#     test "destroying a Recommendation" do
#       visit recommendations_url
#       page.accept_confirm do
#         click_on "Destroy", match: :first
#       end

#       assert_text "Recommendation was successfully destroyed"
#     end
#   end
# end
