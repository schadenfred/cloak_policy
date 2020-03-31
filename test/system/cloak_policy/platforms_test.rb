# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase

  Given { javascript }
  Given(:platform) { platforms(:facebook) }

  describe "index" do

    Given do
      visit platforms_path
      within "#platform-#{platform.id}" do
        click_link "deactivate"
      end
    end

    Then { assert platform.recommendable }
  end

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

  # describe "update" do
  #   describe "setting" do
  #     Given do
  #       within "#setting-#{settings(:one).id}" do
  #         click_link href: edit_setting_path(settings(:one).id)
  #       end
  #       within "#setting-#{settings(:one).id}" do
  #         fill_in "setting_name", with: "some new name"
  #         click_button "Update Setting"
  #       end
  #     end

  #     Then { assert_equal settings(:one).reload.name, "some new name" }
  #   end

  #   describe "choice" do
  #     Given do
  #       within "#choice-#{choices(:one).id}" do
  #         click_link href: edit_choice_path(choices(:one).id)
  #       end

  #       within "#setting-choices-#{choices(:one).setting.id}" do
  #         fill_in "Name", with: "some new name"
  #         click_button "Update Choice"
  #       end
  #     end

  #     Then { assert_equal choices(:one).reload.name, "some new name" }
  #   end
  # end
end
