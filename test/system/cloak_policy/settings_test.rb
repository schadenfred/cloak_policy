require "application_system_test_case"

module CloakPolicy
  class SettingsTest < ApplicationSystemTestCase

    include Engine.routes.url_helpers

    setup do
      @setting = cloak_policy_settings(:one)
      @routes = Engine.routes
    end

    test "visiting the index" do
      visit cloak_policy.settings_url
      assert_selector "h1", text: "Settings"
    end

    # test "creating a Setting" do
    #   visit settings_url
    #   click_on "New Setting"

    #   fill_in "Edit url", with: @setting.edit_url
    #   filltest__in "Name", with: @setting.name
    #   fill_in "Page", with: @setting.page
    #   fill_in "Platform", with: @setting.platform_id
    #   check "Recommendable" if @setting.recommendable
    #   fill_in "Row order", with: @setting.row_order
    #   fill_in "They say", with: @setting.they_say
    #   fill_in "We say", with: @setting.we_say
    #   click_on "Create Setting"

    #   assert_text "Setting was successfully created"
    #   click_on "Back"
    # end

    # test "updating a Setting" do
    #   visit settings_url
    #   click_on "Edit", match: :first

    #   fill_in "Edit url", with: @setting.edit_url
    #   fill_in "Name", with: @setting.name
    #   fill_in "Page", with: @setting.page
    #   fill_in "Platform", with: @setting.platform_id
    #   check "Recommendable" if @setting.recommendable
    #   fill_in "Row order", with: @setting.row_order
    #   fill_in "They say", with: @setting.they_say
    #   fill_in "We say", with: @setting.we_say
    #   click_on "Update Setting"

    #   assert_text "Setting was successfully updated"
    #   click_on "Back"
    # end

    # test "destroying a Setting" do
    #   visit settings_url
    #   page.accept_confirm do
    #     click_on "Destroy", match: :first
    #   end

    #   assert_text "Setting was successfully destroyed"
    # end
  end
end
