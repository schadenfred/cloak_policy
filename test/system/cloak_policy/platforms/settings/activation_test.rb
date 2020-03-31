# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase

  Given { javascript }

  Given(:platform)   { platforms(:facebook) }

  # describe "platform" do

  #   describe "deactivate" do

  #     Given do
  #       visit platforms_path
  #       within "#platform-#{platform.id}" do
  #         click_link "deactivate"
  #       end
  #     end

  #     Then { refute platform.reload.recommendable }
  #   end

  #   describe "activate" do

  #     Given(:inactive_platform) { platforms(:gmail) }
  #     Given do
  #       visit platforms_path
  #       within "#platform-#{inactive_platform.id}" do
  #         click_link "activate"
  #       end
  #     end

  #     Then { assert inactive_platform.reload.recommendable }
  #   end
  # end

  describe "setting" do

    Given(:setting) { settings(:one) }

    describe "deactivate" do

      Given do
        visit platform_path(platform)
        within "#setting-#{setting.id}" do
          click_link "deactivate"
        end
      end

      Then { refute setting.reload.recommendable }
    end


    describe "activate" do

      Given(:inactive_setting) { settings(:two) }
      Given do
        visit platform_path(platform)
        save_and_open_page
        within "#setting-#{inactive_setting.id}" do
          click_link "deactivate"
        end
      end

      Then { assert setting.reload.recommendable }
    end
  end
end
  # Then { save_and_open_page }
  # assert sone.recommendable }
  #     Given { click_link href: deactivate_setting_path(sone) }
  #     Then { assert page.has_link?(href: activate_setting_path(sone)) }

  #     describe "#activate" do
          #       Given { click_link href: activate_setting_path(sone) }
          #       Then { assert page.has_link?(href: deactivate_setting_path(sone)) }
          #     end
      #   end
      # end
    # end
  # end
# end
    # activation" do

    # Given(:sone)    { settings(:one) }
    # Given(:stwo)    { settings(:two) }
    # Given(:choice1) { choices(:one) }
    # Given(:choice2) { choices(:two) }
    # Given(:choice3) { choices(:three) }
    # Given { visit platform_path(platforms(:facebook)) }

    # describe "settings" do
    #   describe "#deactivate" do
    #     Given { assert sone.recommendable }
    #     Given { click_link href: deactivate_setting_path(sone) }
    #     Then { assert page.has_link?(href: activate_setting_path(sone)) }

    #     describe "#activate" do
    #       Given { click_link href: activate_setting_path(sone) }
    #       Then { assert page.has_link?(href: deactivate_setting_path(sone)) }
    #     end
    #   end
    # end

    # describe "choices" do
    #   Given(:deactivate_url)  { "/choices/#{choice1.id}/deactivate" }
    #   Given(:activate_url)    { "/choices/#{choice1.id}/activate" }

    #   describe "#deactivate" do
    #     Given { assert choice1.recommendable }
    #     Given do
    #       within "#choice-#{choice1.id}" do
    #         click_link href: deactivate_choice_path(choice1)
    #       end
    #     end

    #     Then {assert page.has_link?(href: activate_choice_path(choice1))}

    #     describe "#activate" do
    #       Given do
    #         within "#choice-#{choice1.id}" do
    #           click_link href: activate_choice_path(choice1)
    #         end
    #       end

    #       Then { assert page.has_link?(href: deactivate_choice_path(choice1)) }
    #     end
    #   end
    # end
  # end
