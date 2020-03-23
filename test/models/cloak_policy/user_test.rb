# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "sets refresh token when created" do
    user = create(:user)
    assert user.refresh_token.present?
  end

  test "sets installation_step to initial when installed" do
    user = create(:user)
    assert_equal "initial", user.installation_step
  end
end