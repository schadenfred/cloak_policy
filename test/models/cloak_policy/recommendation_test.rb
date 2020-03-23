# frozen_string_literal: true

require "test_helper"

describe Recommendation do
  Given(:subject) { Recommendation.new }

  describe "db" do
    specify "columns" do
      must have_db_column(:benefit).of_type(:text)
      must have_db_column(:description)
      must have_db_column(:name)
      must have_db_column(:housable).of_type(:boolean)
    end
  end

  describe "associations" do
    specify "has_one" do
      must have_one :recommendations_use_case
      must have_one :use_case
      must have_many :preferences
    end

    specify "has_many" do
      must have_many :choices
      must have_many :chosens
      must have_many :recommendations_settings
      must have_many :settings
      must have_many :platforms
    end
  end

  Given(:platform) { platforms(:facebook) }
  Given(:setting) { settings(:one) }
  Given(:choice)  { choices(:one) }
  Given(:recommendation) { recommendations(:kardashian) }

  describe "profile" do
    Then { assert_equal recommendation.profile, profiles(:executive) }
  end

  describe "use_case" do
    Then { assert_equal recommendation.use_case, use_cases(:business) }
  end


  describe ":launchable" do
    Then { assert_includes recommendation.launchable.pluck(:name), "facebook" }
  end

  describe "clone" do
    Given(:cloned) { recommendation.clone_rec(name: "clone of blah") }

    Then { assert_equal cloned.name, "clone of blah" }

    describe "must create a new recommendation" do
      Then { assert_difference(["Recommendation.count"], 1) { cloned } }
    end

    describe "must create the same number of chosens" do
      Then { assert_difference(["Chosen.count"], 5) { cloned.save } }
    end

    describe "must have the same platforms selected" do
      Given { assert_equal recommendation.recommendations_platforms.count, 3 }
      Then { assert_difference(["RecommendationsPlatform.count"], 3) { cloned.save } }
    end
  end

  describe "recommend!(choice)" do
    Given(:rec) { recommendations(:kardashian) }

    describe "must create a new chosen if none exists" do
      Given { rec.chosens.delete_all }
      Then { assert_difference("Chosen.count") { rec.recommend! choice } }
    end

    describe "wont create new chosen if previous exists" do
      Then { assert_no_difference("Chosen.count") { rec.recommend! choice } }
      And  { assert rec.chosens.find_by(choice_id: choice.id).recommendable }
    end

    describe "new chosen must be recommendable" do
      Given { rec.recommend! choice }
      Then { assert rec.chosens.find_by(choice_id: choice.id).recommendable }
    end

    describe "switch chosen" do
      Given(:previous_chosen) { chosens(:one) }
      Given(:current_chosen)  { chosens(:four) }

      describe "must make previous chosen not recommendable" do
        Given { assert_equal previous_chosen.recommendable, true }
        Given { rec.recommend!(current_chosen.choice) }
        Then { assert current_chosen.reload.recommendable }
        And  { assert_not previous_chosen.reload.recommendable }
      end
    end
  end
end
