# require "application_system_test_case"

# module CloakPolicy
#   class PlatformsTest < ApplicationSystemTestCase
#     setup do
#       @platform = cloak_policy_platforms(:one)
#     end

#     test "visiting the index" do
#       visit platforms_url
#       assert_selector "h1", text: "Platforms"
#     end

#     test "creating a Platform" do
#       visit platforms_url
#       click_on "New Platform"

#       fill_in "Description", with: @platform.description
#       fill_in "Fqdn", with: @platform.fqdn
#       fill_in "Icon", with: @platform.icon
#       fill_in "Name", with: @platform.name
#       fill_in "Platform type", with: @platform.platform_type
#       check "Recommendable" if @platform.recommendable
#       fill_in "They say", with: @platform.they_say
#       fill_in "We say", with: @platform.we_say
#       click_on "Create Platform"

#       assert_text "Platform was successfully created"
#       click_on "Back"
#     end

#     test "updating a Platform" do
#       visit platforms_url
#       click_on "Edit", match: :first

#       fill_in "Description", with: @platform.description
#       fill_in "Fqdn", with: @platform.fqdn
#       fill_in "Icon", with: @platform.icon
#       fill_in "Name", with: @platform.name
#       fill_in "Platform type", with: @platform.platform_type
#       check "Recommendable" if @platform.recommendable
#       fill_in "They say", with: @platform.they_say
#       fill_in "We say", with: @platform.we_say
#       click_on "Update Platform"

#       assert_text "Platform was successfully updated"
#       click_on "Back"
#     end

#     test "destroying a Platform" do
#       visit platforms_url
#       page.accept_confirm do
#         click_on "Destroy", match: :first
#       end

#       assert_text "Platform was successfully destroyed"
#     end
#   end
# end
