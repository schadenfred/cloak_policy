# frozen_string_literal: true

require "application_system_test_case"

class SignInOutTest < ApplicationSystemTestCase
  test "sign in" do
    user = User.create(email: "test@example.com", password: "password")
    user.confirm
    visit new_user_session_path
    fill_in "signInEmail", with: "test@example.com"
    fill_in "user_password", with: "password"
    click_button "Log in"
    assert_equal current_path, root_path
  end
end
