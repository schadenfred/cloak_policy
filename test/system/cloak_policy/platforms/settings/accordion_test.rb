# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase

  Given { javascript }

  Given(:sone)    { settings(:one) }
  Given(:stwo)    { settings(:two) }
  Given(:choice1) { choices(:one) }
  Given(:choice2) { choices(:two) }
  Given(:choice3) { choices(:three) }

  Given { visit platform_path(platforms(:facebook)) }

  describe "initial state" do
    describe "must show settings as accordions" do
      Then do
        assert page.find("#accordion-setting-#{sone.id}")
        assert page.find("#accordion-setting-#{stwo.id}")
      end
    end

    describe "first setting must be expanded" do
      Then do
        assert page.has_link?(href: deactivate_setting_path(sone))
        assert_selector "#setting-#{sone.id}"
        within "#setting-#{sone.id}" do
          assert_link('deactivate')
          assert_text "Choices:"
        end
      end
    end

    describe "second setting must be collapsed" do
      Then do
        assert_selector "#setting-#{stwo.id}"
        within "#setting-#{stwo.id}" do
          refute_link("deactivate")
          refute_text "Choices:"
        end
      end
    end
  end

  describe "collapse from expanded" do
    Given do
      within "#setting-#{sone.id}" do
        assert_link("deactivate")
        assert_text "Choices:"
      end
    end

    Given do
      within "#accordion-setting-#{sone.id}" do
        click_button
      end
    end

    Then do
      within "#setting-#{sone.id}" do
        refute_link("deactivate")
        refute_text "Choices:"
      end
    end
  end

  describe "expand from collapsed" do
    Given do
      within "#setting-#{stwo.id}" do
        refute_link("deactivate")
        refute_text "Choices:"
      end
    end

    Given do
      within "#accordion-setting-#{stwo.id}" do
        click_button
      end
    end

    Then do
      within "#setting-#{stwo.id}" do
        assert_link("deactivate")
        assert_text "Choices:"
      end
    end
  end
end
