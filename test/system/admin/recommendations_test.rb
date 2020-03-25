require "application_system_test_case"

class Admin::RecommendationsTest < ApplicationSystemTestCase

  Given(:recommendation)  { recommendations(:kardashian)}
  Given(:facebook)        { platforms(:facebook) }
  Given(:twitter)         { platforms(:twitter) }
  Given(:google)          { platforms(:google) }

  Given { sign_in_admin }

  describe "see all recommendations" do

    Given { visit admin_recommendations_path }

    Then { assert_content recommendation.name }
  end

  describe "new recommendation" do

    Given { google.deactivate! }
    Given { visit new_recommendation_url }

    describe "facebook will be selected by default" do

      # Then {
      #   assert page.has_field?('facebook', checked: true)
      #   assert page.has_field?('twitter', checked: false) }
    end

    describe "only active platforms will be presented" do

      # Then { refute page.has_field?('google') }
    end

    describe "create" do

      Given(:recommendation) { Recommendation.last }

      Given do within "#new_recommendation" do
          fill_in "Name", with: "digital vegan"
          uncheck "facebook"
          check "twitter"
          click_on "Create Recommendation"
        end
      end

      # Then {
      #   assert_equal recommendation.name, "digital vegan"
      #   assert_includes recommendation.platforms, twitter
      #   refute_includes recommendation.platforms, facebook }
    end
  end
end

