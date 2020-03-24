require 'test_helper'

module CloakPolicy

  describe Setting do

    Given(:subject) { Setting.new }

    describe "db" do
      specify "columns" do
        must have_db_column(:edit_url)
        must have_db_column(:name)
        must have_db_column(:row_order).of_type(:integer)
        must have_db_column(:they_say)
        must have_db_column(:we_say)
      end
    end

    specify "associations" do
      must belong_to(:platform).optional
      must have_many :choices
      must have_many :scores
      must have_many :vectors
    end

    specify "validations" do
      must validate_presence_of(:name)
      must validate_uniqueness_of(:name).case_insensitive.scoped_to(:platform_id)
    end

    Given(:platform) { platforms(:facebook) }
    Given(:setting) { settings(:one) }
    Given(:choice) { choices(:one) }
    Given { platform.activate! }
    Given { setting.activate! }
    Given { choice.activate! }

    Then { assert subject.platform.nil? }

    describe "recommendable_choices" do

      Then { assert_includes setting.recommendable_choices, choice }

      describe "wont be recommendable if deactivated" do

        Given { choice.deactivate! }
        Then { assert_not_includes setting.recommendable_choices, choice }
      end
    end

    describe "row_order_rank" do
      Given {
        settings(:one).update_attribute   :row_order_position, 0
        settings(:two).update_attribute   :row_order_position, 1
        settings(:three).update_attribute :platform_id, settings(:one).platform_id
        settings(:three).update_attribute :row_order_position, 2
      }

      When  { settings(:two).update_attribute :row_order_position, 0 }

      Then {
        assert_equal settings(:one).row_order_rank, 1
        assert_equal settings(:two).row_order_rank, 0
        assert_equal settings(:three).row_order_rank, 2
      }
    end
  end

end
