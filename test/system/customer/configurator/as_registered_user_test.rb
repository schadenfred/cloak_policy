# # frozen_string_literal: true

# require "application_system_test_case"

# class AsRegisteredUserTest < ApplicationSystemTestCase
#   Given(:install_as_guest) do
#     params = { "extension-id" => "54321", "browser-install-id" => "12345" }
#     visit configurator_index_path(params)
#   end

#   Given(:user) { users(:one)  }

#   Given(:login) do
#     visit new_user_session_path
#     fill_in "signInEmail", with: user.email
#     fill_in "user_password", with: "pa77ssword"
#     click_button "Log in"
#   end

#   describe "must redirect to :install if no browser_install" do
#     Given { user.browser_installs.destroy_all }
#     Given { login }

#     Then { assert_equal page.current_path, configurator_path(:install) }
#   end

#   describe "must redirect to :select_identity if no use_case" do
#     Given { user.update(use_case_id: nil)  }
#     Given { login }

#     Then { assert_equal page.current_path, configurator_path(:select_identity) }
#   end

#   describe "must redirect to :analyze if use_case selected" do
#     Given { login }

#     Then { assert_equal page.current_path, configurator_path(:analyze) }
#   end
# end
