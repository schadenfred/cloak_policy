# # frozen_string_literal: true

# require "application_system_test_case"

# class SubscribeTest < ApplicationSystemTestCase
#   include Capybara::Email::DSL

#   describe "choose plan" do
#     Given { visit configurator_path(:subscribe) }
#     Given { click_link("Get started") }

#     describe "must authenticate" do
#       Then { assert_equal page.current_path, new_user_session_path }

#       describe "registered user" do
#         Given { fill_in "signInEmail", with: users(:two).email }
#         Given { fill_in "Password", with: "pa77ssword" }
#         Given { click_button "Log in" }
#       end

#       describe "unregistered user" do
#         Given(:unregistered_email) { "unregistered@example.com" }
#         Given { fill_in "signUpEmail", with: unregistered_email }
#         Given { click_button "Sign up" }
#         Given { open_email unregistered_email }
#         Given { current_email.click_link "Confirm my account" }
#         Given do
#           fill_in "New password", with: "pa$$word"
#           fill_in "Confirm new password", with: "pa$$word"
#           click_button "Set my password"
#         end

#         Then { assert_match(/subscription\/new/, page.current_url) }
#       end
#     end
#   end
# end
