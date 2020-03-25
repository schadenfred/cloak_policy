# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase
  Given { javascript }
  Given { sign_in }
  Given(:platform) { platforms(:facebook) }
  Given { visit admin_platform_path(platform) }

  describe "new setting form" do
    Given { refute_selector ".accordion", text: "Who can see muh grbils?" }
    Given { click_link "New setting" }
    Given { assert_selector ".accordion", text: "New Facebook setting:" }

    describe "create" do
      Given do
        within "#newSetting" do
          fill_in "Page", with: "/foo/bar"
          fill_in "Name", with: "Who can see muh grbils?"
          click_button "Create Setting"
        end
      end

      Then { assert_selector ".accordion", text: "Who can see muh grbils?" }
    end
  end
end
