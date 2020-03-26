# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe Vector do

    Given(:subject) { Vector.new }

    specify "associations" do
      must have_many(:scores)
      must have_many(:settings)
      must have_many(:subvectors)
    end

    Given(:vector) { vectors(:privacy)}
    Given(:subvector) { vectors(:location)}

    describe "scopes" do

      describe ":top_level" do
        Then {
          assert Vector.top_level.include? vector }

        And  { refute Vector.top_level.include? subvector }
        And  { assert vector.subvectors.include? subvector }
      end
    end

    describe ":full_name" do

      Then { assert_equal vector.full_name, vector.name }
    end

    describe ":all_settings" do

      Then {
        # assert_includes vector.settings, settings(:two)
        # assert_includes subvector.settings, settings(:three)
        # assert_equal vector.settings.count, 2
        # assert_equal subvector.settings.count, 1
        # assert_equal vector.all_settings.count, 4
      }
    end
  end
end