# frozen_string_literal: true

require "application_system_test_case"

class PlatformsTest < ApplicationSystemTestCase

  Given { javascript }

  Given(:platform)  { platforms(:facebook) }
  Given(:setting)   { settings(:one) }
  Given(:choice)    { choices(:one) }

  describe "platform" do

    Given { visit platforms_path }

    describe "deactivate" do

      Given { click_link("platformDeactivate-#{platform.id}")  }

      Then  { refute platform.reload.recommendable }

      describe "activate" do

        Given { click_link("platformActivate-#{platform.id}")  }

        Then  { assert platform.reload.recommendable }
      end
    end
  end

  describe "setting" do

    Given { visit platform_path(platform) }

    describe "deactivate" do

      Given { click_link("settingDeactivate-#{setting.id}")  }

      Then { refute setting.reload.recommendable }

      describe "activate" do

        Given { click_link("settingActivate-#{setting.id}")  }

        Then { assert setting.reload.recommendable }

        describe "choice" do

          describe "deactivate" do

            Given { click_link("choiceDeactivate-#{choice.id}")  }

            Then { refute choice.reload.recommendable }

            describe "activate" do

              Given { click_link("choiceActivate-#{choice.id}")  }

              Then { assert choice.reload.recommendable }
            end
          end
        end
      end
    end
  end
end
