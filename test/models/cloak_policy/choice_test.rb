require 'test_helper'

describe Choice do

  Given(:subject) { Choice.new }

  describe "db" do

    specify "columns" do

      must have_db_column(:category_choice_id).of_type(:integer)
      must have_db_column(:description)
      must have_db_column(:development_recommendation_id).of_type(:integer)
      must have_db_column(:edit_url)
      must have_db_column(:fqurl)
      must have_db_column(:name)
      must have_db_column(:recommendable).of_type(:boolean)
      must have_db_column(:setting_id)
      must have_db_column(:value)
    end
  end

  specify "associations" do

    must belong_to(:development_recommendation).optional
    must belong_to :setting

    must have_many :chosens
    must have_many :recommendations
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

    Then { assert_equal choice.impact_for(vectors(:privacy)), 'yuuuge' }
  end

  describe ":create_development_recommendation" do

    describe "must generate a new recommendation" do

      Then { assert_difference(['Recommendation.count'], 1) {
        choice.create_development_recommendation} }
    end

    describe "must generate a new chosen" do

      Then { assert_difference(['Chosen.count'], 1) {
        choice.create_development_recommendation} }
    end

    describe "must generate a new recommendation_platform" do

      Then { assert_difference(['RecommendationsPlatform.count'], 1) {
        choice.create_development_recommendation} }
    end

    describe "must have correct associations" do

      Given { choice.create_development_recommendation }
      Given(:dev_rec) { Recommendation.last }
      Given(:platforms) { dev_rec.platforms }
      Then { assert_equal dev_rec.chosens.last.choice_id, choice.id }
      And { assert_match /Isolation/, dev_rec.name  }
      And { assert_includes platforms.pluck(:id), choice.setting.platform.id }
    end
  end
end
