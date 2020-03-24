require "application_system_test_case"

module CloakPolicy
  class ScoresTest < ApplicationSystemTestCase
    setup do
      @score = cloak_policy_scores(:one)
    end

    test "visiting the index" do
      visit scores_url
      assert_selector "h1", text: "Scores"
    end

    test "creating a Score" do
      visit scores_url
      click_on "New Score"

      fill_in "Impact", with: @score.impact
      fill_in "Points", with: @score.points
      fill_in "Scorable", with: @score.scorable_id
      fill_in "Scorable type", with: @score.scorable_type
      fill_in "Vector", with: @score.vector_id
      click_on "Create Score"

      assert_text "Score was successfully created"
      click_on "Back"
    end

    test "updating a Score" do
      visit scores_url
      click_on "Edit", match: :first

      fill_in "Impact", with: @score.impact
      fill_in "Points", with: @score.points
      fill_in "Scorable", with: @score.scorable_id
      fill_in "Scorable type", with: @score.scorable_type
      fill_in "Vector", with: @score.vector_id
      click_on "Update Score"

      assert_text "Score was successfully updated"
      click_on "Back"
    end

    test "destroying a Score" do
      visit scores_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Score was successfully destroyed"
    end
  end
end
