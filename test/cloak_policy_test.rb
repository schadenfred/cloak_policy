require 'test_helper'

class CloakPolicy::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, CloakPolicy
  end
end
