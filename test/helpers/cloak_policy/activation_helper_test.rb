require 'test_helper'

include CloakPolicy::ActivationHelper

class ActivationHelperTest < ActiveSupport::TestCase

  Given(:platform) { platforms(:facebook) }
  Given(:setting) { settings(:one) }
  Given(:choice)  { choices(:one) }

  Given { [platform, setting, choice].each.map { |r| r.activate! } }
  Given { assert choice.recommendable }

  describe "platform" do

    describe "platform active" do

      Then { assert_match /deactivate_platform_path/, activation_link_for(platform)}
    end

    describe "platform inactive" do

      # Given { choice.deactivate! }

      # Then { assert_match /activate_choice_path/, activation_link_for(choice) }
    end
  end

  describe "choice" do
Given { skip }
    describe "choice active" do

      Then { assert_match /deactivate_choice_path/, activation_link_for(choice)}
    end

    describe "choice inactive" do

      Given { choice.deactivate! }

      Then { assert_match /activate_choice_path/, activation_link_for(choice) }
    end

    describe "choice active setting inactive" do

      Given { setting.deactivate! }

      Then { assert_match /inactive/, activation_link_for(choice) }
    end

    describe "choice and setting active, platform inactive" do

      Given { platform.deactivate! }

      Then { assert_match /inactive/, activation_link_for(choice) }
    end
  end

  describe "setting" do
    Given { skip }

    describe "settingrecord and platform active" do

      Given(:expected) {"deactivate_setting_path(setting)" }

      Then { assert_match expected, activation_link_for(setting) }
    end

    describe "setting inactive and platform active" do

      Given { setting.deactivate! }
      Given(:expected) {"deactivate_setting_path(setting)" }

      Then { refute_match expected, activation_link_for(setting) }
    end

    describe "setting active and platform inactive" do

      Given { platform.deactivate! }
      Given(:expected) {"deactivate_setting_path(setting)" }

      Then { refute_match expected, activation_link_for(setting) }
    end

    describe "setting inactive and platform inactive" do

      Given { platform.deactivate! }
      Given { setting.deactivate! }
      Given(:expected) {"deactivate_setting_path(setting)" }

      Then { refute_match expected, activation_link_for(setting) }
    end
  end
end