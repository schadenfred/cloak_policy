# # frozen_string_literal: true

# require "application_system_test_case"

# class AsInvitedUserTest < ApplicationSystemTestCase
#   include Capybara::Email::DSL

#   Given(:user) { users(:one) }
#   Given(:invited_email) { "invited@example.com" }

#   Given { User.invite!({ email: invited_email }, user) { |u| u.skip_invitation = true } }

#   Given(:invited_user) { User.find_by(email: invited_email) }

#   Given(:install_as_guest) do
#     visit configurator_index_path
#   end

#   Given(:claim_invitation) do
#     click_link "Login"
#     fill_in "signUpEmail", with: invited_email
#     click_button "Sign up"
#     assert_equal page.current_path, configurator_path(:claim_invitation)
#     open_email invited_email
#     current_email.click_link "Accept invitation"
#     fill_in(id: "user_password", with: "pa%%word")
#     fill_in(id: "user_password_confirmation", with: "pa%%word")
#     click_button(type: "submit")
#   end

#   describe "invited user from install step as guest" do

#     Given { visit configurator_index_path }
#     Given { claim_invitation }

#     Then { assert_equal page.current_path, configurator_path(:install) }
#   end
# end
