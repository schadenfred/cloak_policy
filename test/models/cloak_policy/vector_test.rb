# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe Vector do

    Given(:subject) { Vector.new }

    describe "db" do

      specify "columns" do

        must have_db_column(:name)
        must have_db_column(:description)
        must have_db_column(:icon)
        must have_db_column(:parent_id).of_type(:integer)
      end
    end

    describe "associations" do

      specify "belongs_to" do
        must belong_to(:parent).optional
    end

      specify "has_many" do
        must have_many(:scores)
        must have_many(:settings)
        must have_many(:subvectors)
      end
    end

    Given(:vector) { vectors(:privacy)}
    Given(:subvector) { vectors(:location)}

    describe "newly created vector" do

      Given(:new_vector) { Vector.last }

      describe "must create a new score with itself as its own vector" do

        Given(:action) { Vector.create(name: 'sharing')}

        Then { assert_difference(['Score.count'] ) { action } }
        And  { assert_equal new_vector.name, 'sharing'}
        And  { assert_equal new_vector.scores.last.vector, new_vector }
      end

      describe "newly created subvector" do

        Given(:action) { vector.subvectors.create(name: 'presence') }

        Then { assert_difference(['Score.count'] ) { action } }
        And  { assert_equal new_vector.name, 'presence'}
        And  { assert_equal new_vector.scores.last.vector, vector }
        And  { assert_includes vector.subvectors, new_vector  }
      end
    end

    describe "scopes" do

      describe ":top_level" do

        Then { assert Vector.top_level.include? vector }

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