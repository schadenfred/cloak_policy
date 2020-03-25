# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase
  Given { javascript }
  Given { sign_in_admin }
  Given(:platform) { platforms(:facebook) }
  Given { visit admin_platform_path(platform) }

  describe "update" do
    describe "setting" do
      Given do
        within "#setting-#{settings(:one).id}" do
          click_link href: edit_admin_setting_path(settings(:one).id)
        end
        within "#setting-#{settings(:one).id}" do
          fill_in "Name", with: "some new name"
          click_button "Update Setting"
        end
      end

      Then { assert_equal settings(:one).reload.name, "some new name" }
    end

    describe "choice" do
      Given do
        within "#choice-#{choices(:one).id}" do
          click_link href: edit_admin_choice_path(choices(:one).id)
        end

        within "#setting-choices-#{choices(:one).setting.id}" do
          fill_in "Name", with: "some new name"
          click_button "Update Choice"
        end
      end

      Then { assert_equal choices(:one).reload.name, "some new name" }
    end
  end
end
