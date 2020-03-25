# require "application_system_test_case"

# class VectorsTest < ApplicationSystemTestCase
#   setup do
#     @vector = vectors(:one)
#   end

#   test "visiting the index" do
#     visit vectors_url
#     assert_selector "h1", text: "Vectors"
#   end

#   test "creating a Vector" do
#     visit vectors_url
#     click_on "New Vector"

#     click_on "Create Vector"

#     assert_text "Vector was successfully created"
#     click_on "Back"
#   end

#   test "updating a Vector" do
#     visit vectors_url
#     click_on "Edit", match: :first

#     click_on "Update Vector"

#     assert_text "Vector was successfully updated"
#     click_on "Back"
#   end

#   test "destroying a Vector" do
#     visit vectors_url
#     page.accept_confirm do
#       click_on "Destroy", match: :first
#     end

#     assert_text "Vector was successfully destroyed"
#   end
# end
