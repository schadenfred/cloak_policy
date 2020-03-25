# frozen_string_literal: true

require "application_system_test_case"

class InvitationsTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper
  include Capybara::Email::DSL

  describe "invite" do
    Given { users(:invited_user).destroy }

    Given(:user) { users(:one) }
    Given { login user }

    Given { visit invitations_path }
    Given { fill_in "Email", with: "invited@example.com" }
    Given(:invite) { click_button "Send an invitation" }

    describe "must create unconfirmed user" do
      Then { assert_difference("User.count", 1) { invite } }
      And  { assert_not User.last.confirmed? }
    end
  end
end
