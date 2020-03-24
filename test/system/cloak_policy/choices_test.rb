# require "application_system_test_case"

# module CloakPolicy
#   class ChoicesTest < ApplicationSystemTestCase
#     setup do
#       @choice = choices(:one)
#     end

#     test "visiting the index" do
#       visit choices_url
#       assert_selector "h1", text: "Choices"
#     end

#     test "creating a Choice" do
#       visit choices_url
#       click_on "New Choice"

#       fill_in "Development recommendation", with: @choice.development_recommendation_id
#       fill_in "Name", with: @choice.name
#       check "Recommendable" if @choice.recommendable
#       fill_in "Setting", with: @choice.setting_id
#       fill_in "They say", with: @choice.they_say
#       fill_in "We say", with: @choice.we_say
#       click_on "Create Choice"

#       assert_text "Choice was successfully created"
#       click_on "Back"
#     end

#     test "updating a Choice" do
#       visit choices_url
#       click_on "Edit", match: :first

#       fill_in "Development recommendation", with: @choice.development_recommendation_id
#       fill_in "Name", with: @choice.name
#       check "Recommendable" if @choice.recommendable
#       fill_in "Setting", with: @choice.setting_id
#       fill_in "They say", with: @choice.they_say
#       fill_in "We say", with: @choice.we_say
#       click_on "Update Choice"

#       assert_text "Choice was successfully updated"
#       click_on "Back"
#     end

#     test "destroying a Choice" do
#       visit choices_url
#       page.accept_confirm do
#         click_on "Destroy", match: :first
#       end

#       assert_text "Choice was successfully destroyed"
#     end
#   end
# end
