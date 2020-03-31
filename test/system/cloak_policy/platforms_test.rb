# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase

  Given { javascript }
  Given(:platform) { platforms(:facebook) }

  describe "create" do
    Given do
      visit new_platform_path
      fill_in "platform_name", with: "pinterest"
      click_button "Create Platform"
    end

    Then { assert_includes CloakPolicy::Platform.pluck(:name), 'pinterest' }
  end

  describe "update" do
    Given do
      visit edit_platform_path(platform)
      fill_in "platform_name", with: "instagoogs"
      click_button "Update Platform"
    end

    Then { assert_includes CloakPolicy::Platform.pluck(:name), 'instagoogs' }
  end
end
