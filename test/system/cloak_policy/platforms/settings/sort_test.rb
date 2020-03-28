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

  describe "sortable" do
    describe "on page load" do
      describe ".setting-grabber must not show as active" do
        Then { refute_selector ".mdi-arrows.mdi-hc-lg.mdc-text-blue" }
      end

      describe "sortable must be disabled" do
        Then { assert_selector ".ui-sortable-disabled" }
      end
    end

    describe "when .setting-grabber is clicked" do
      Given do
        within first(".setting-grabber") do
          find("i.icon.mdi-arrows").click
        end
      end

      describe "expanded accordions must collapse" do
        Then do
          within "#setting-#{sone.id}" do
            refute_text "Choices:"
            refute_link "deactivate"
          end

          within "#setting-#{stwo.id}" do
            refute_text "Choices:"
            refute_link "deactivate"
          end
        end
      end

      describe "grabber icon must show as active (blue)" do
        Then { assert_selector "i.icon.mdi-arrows.mdi-hc-lg.mdc-text-blue" }
      end

      describe "sortable must be enabled" do
        Then { assert_selector ".ui-sortable" }
        And  { refute_selector ".ui-sortable-disabled" }
      end

      describe "accordion collapse must disable" do
        Given { page.find("#accordion-setting-#{sone.id}").click }

        describe ".setting-grabber must not show as active" do
          Then { refute_selector "i.icon.mdi-arrows.mdi-hc-lg.mdc-text-blue" }
        end

        describe "sortable must be disabled" do
          Then { assert_selector ".ui-sortable-disabled" }
        end
      end
    end
  end
end
