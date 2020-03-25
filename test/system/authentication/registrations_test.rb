# frozen_string_literal: true

require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper
  include Capybara::Email::DSL

  describe "register" do
    Given { visit new_user_registration_path }
    Given { fill_in "Email", with: "test@example.com" }

    describe "must create unconfirmed user" do
      Given { click_button "Sign up" }
      Then { assert_not User.where(guest: false).last.confirmed? }
    end

    describe "must send confirmation email to unconfirmed user" do
      Then { assert_emails(1) { click_button "Sign up" } }
    end

    describe "confirmation email" do
      Given { click_button "Sign up" }
      Given { open_email "test@example.com" }

      describe "must be properly formed" do
        # Then do
        #   assert_equal current_email.to.first, "test@example.com"
        #   assert_equal current_email.from.first, "info@recallapi.com"
        #   assert_equal current_email.subject, "Confirmation instructions"
        # end
      end

      describe "click confirmation link" do
        Given { current_email.click_link "Confirm my account" }
        # Then { assert_equal page.current_path, edit_user_password_path }

        describe "set password" do
          Given do
            fill_in "New password", with: "pa$$word"
            fill_in "Confirm new password", with: "pa$$word"
            click_button "Set my password"
          end

          describe "user should be confirmed" do
            # Then { assert User.last.confirmed? }
          end

          describe "user should be redirected" do
            # Then { assert_equal page.current_path, configurator_path(:install) }
          end
        end
      end
    end
  end
end
