# frozen_string_literal: true

require "application_system_test_case"

class AsGuestUserTest < ApplicationSystemTestCase
  Given(:params) { {  } }
  Given(:use_case) { use_cases(:business) }
  Given(:guest) { User.where(guest: true).last }

  describe "when extension not installed" do

    %w[install welcome select_identity analyze].each do |step|
      describe "redirects from #{step.to_sym} to :install" do
        Given { visit configurator_path(step, params) }
        # Then { assert_match(/configurator\/install/, page.current_url) }
      end
    end

    describe "redirects from from configurator index to :install" do
      describe "without correct params" do
        Given(:params) { nil }
        Given { visit configurator_index_path(params) }
        # Then { assert_match(/configurator\/install/, page.current_url) }
      end
    end
  end

  describe "from install step" do
      Given { visit configurator_path(:install, params) }

      # Then { assert_match(/configurator\/welcome/, page.current_url) }

      describe "and use case selected" do
        Given { guest.update(use_case_id: use_cases(:business).id) }
        Given { visit configurator_path(:install) }
        # Then { assert_match(/configurator\/analyze/, page.current_url) }

        describe "and use case selected" do
          Given { guest.update(use_case_id: use_cases(:business).id) }
          Given { visit configurator_path(:install) }
          # Then { assert_match(/configurator\/analyze/, page.current_url) }
        end
    end
  end

  Given(:get_started) do
    visit configurator_path(:install, params)
    click_link "Get started"
  end

  describe "get started" do
    Given { get_started }

    describe "must create browser install for guest" do
      # Then { assert guest.browser_installed? }
    end

    describe "must go to select identity step" do
      # Then { assert_match(/configurator\/select_identity/, page.current_url) }
    end
  end

  Given(:choose_use_case) do
    get_started
    select(use_case.profile.name, from: "configuration_profile_id")
    select(use_case.name, from: "configuration_use_case_id")
    click_button "Go"
  end

  describe "choose use case" do
    Given { choose_use_case }

    describe "must go to analyze step" do
      # Then { assert_match(/configurator\/analyze/, page.current_url) }
    end

    describe "must set guest's use case" do
      # Then { assert_equal User.last.use_case, use_case }
    end
  end

  Given(:choose_free_platform) do
    javascript
    choose_use_case
    javascript
    page.first(id: "analyzeMySettings").click
  end

  describe "choose free platform" do
    Given { choose_free_platform }

    describe "Should remember guest from browser-install-id" do
      Given(:old_guest) { User.last.email }
      Given { old_guest }
      Given { reset_session! }
      Given { visit configurator_path(:install, params) }

      # Then { assert_equal old_guest, User.last.email }
    end
  end
end
