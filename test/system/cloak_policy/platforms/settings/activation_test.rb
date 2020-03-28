# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase

  Given { javascript }

  describe "activation" do

    Given(:sone)    { settings(:one) }
    Given(:stwo)    { settings(:two) }
    Given(:choice1) { choices(:one) }
    Given(:choice2) { choices(:two) }
    Given(:choice3) { choices(:three) }
    Given { visit platform_path(platforms(:facebook)) }

    describe "settings" do
      describe "#deactivate" do
        Given { assert sone.recommendable }
        Given { click_link href: deactivate_setting_path(sone) }
        Then { assert page.has_link?(href: activate_setting_path(sone)) }

        describe "#activate" do
          Given { click_link href: activate_setting_path(sone) }
          Then { assert page.has_link?(href: deactivate_setting_path(sone)) }
        end
      end
    end

    describe "choices" do
      Given(:deactivate_url)  { "/choices/#{choice1.id}/deactivate" }
      Given(:activate_url)    { "/choices/#{choice1.id}/activate" }

      describe "#deactivate" do
        Given { assert choice1.recommendable }
        Given do
          within "#choice-#{choice1.id}" do
            click_link href: deactivate_choice_path(choice1)
          end
        end

        Then {assert page.has_link?(href: activate_choice_path(choice1))}

        describe "#activate" do
          Given do
            within "#choice-#{choice1.id}" do
              click_link href: activate_choice_path(choice1)
            end
          end

          Then { assert page.has_link?(href: deactivate_choice_path(choice1)) }
        end
      end
    end
  end
end
