require 'test_helper'

module CloakPolicy

  describe Score do
    Given(:subject) { Score.new }

    describe "db" do
      specify "columns" do
        must have_db_column(:impact).of_type(:string)
        must have_db_column(:points).of_type(:integer)
        must have_db_column(:scorable_id).of_type(:integer)
        must have_db_column(:scorable_type)
        must have_db_column(:vector_id).of_type(:integer)
      end
    end

    specify "associations" do
      must belong_to :vector
      must belong_to :scorable
    end

    specify "validations" do
      must validate_presence_of :scorable
      must validate_presence_of :vector
      must validate_uniqueness_of(:vector_id).scoped_to([:scorable_id, :scorable_type])
    end

    describe "Scoring a setting must create scores for each of its choices" do

      Given { Score.destroy_all }
      Given(:action) { settings(:one).scores.create(vector: vectors(:privacy)) }
      Given(:count) { settings(:one).choices.count + 1 }

      # Then { assert_difference(['Score.count'], count ) { action } }
    end
  end

end
