require 'test_helper'

module CloakPolicy
  require 'test_helper'

  describe Choice do

    Given(:subject) { Choice.new }

    describe "db" do

      specify "columns" do

        must have_db_column(:name)
        must have_db_column(:value)
        must have_db_column(:recommendable).of_type(:boolean)
        must have_db_column(:setting_id)
      end
    end

    specify "associations" do

      must belong_to :setting
      must have_many :chosens
    end

    specify "validations" do

      must validate_presence_of(:name)
      must validate_presence_of(:setting)
      must validate_uniqueness_of(:name).case_insensitive.scoped_to(:setting_id)
    end

    describe "must have a platform" do

      Then { assert_equal choice.platform, choice.setting.platform }
    end

    Given(:platform) { platforms(:facebook) }
    Given(:setting) { settings(:one) }
    Given(:choice) { choices(:one) }
    Given(:recommendation) { recommendations(:one) }

    describe "value must return name if nil" do

      Given(:choice) { choices(:boolean_choice) }
      Given { assert_equal choice.value, "1" }
      Given { choice.update(value: nil) }

      Then { assert_equal choice.value, "yes"}
    end

    describe ":impact_for(:vector)" do

      # Then { assert_equal choice.impact_for(vectors(:privacy)), 'yuuuge' }
    end
  end
end
