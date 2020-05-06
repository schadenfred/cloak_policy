# require "application_system_test_case"

# module CloakPolicy
#   class ChosensTest < ApplicationSystemTestCase
#     setup do
#       @chosen = cloak_policy_chosens(:one)
#     end

#     test "visiting the index" do
#       visit chosens_url
#       assert_selector "h1", text: "Chosens"
#     end

#     test "creating a Chosen" do
#       visit chosens_url
#       click_on "New Chosen"

#       fill_in "Advice", with: @chosen.advice
#       fill_in "Choice", with: @chosen.choice_id
#       fill_in "Recommendation", with: @chosen.recommendation_id
#       click_on "Create Chosen"

#       assert_text "Chosen was successfully created"
#       click_on "Back"
#     end

#     test "updating a Chosen" do
#       visit chosens_url
#       click_on "Edit", match: :first

#       fill_in "Advice", with: @chosen.advice
#       fill_in "Choice", with: @chosen.choice_id
#       fill_in "Recommendation", with: @chosen.recommendation_id
#       click_on "Update Chosen"

#       assert_text "Chosen was successfully updated"
#       click_on "Back"
#     end

#     test "destroying a Chosen" do
#       visit chosens_url
#       page.accept_confirm do
#         click_on "Destroy", match: :first
#       end

#       assert_text "Chosen was successfully destroyed"
#     end
#   end
# end
