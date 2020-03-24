require "application_system_test_case"

module CloakPolicy
  class PreferencesUseCasesTest < ApplicationSystemTestCase
    setup do
      @preferences_use_case = cloak_policy_preferences_use_cases(:one)
    end

    test "visiting the index" do
      visit preferences_use_cases_url
      assert_selector "h1", text: "Preferences Use Cases"
    end

    test "creating a Preferences use case" do
      visit preferences_use_cases_url
      click_on "New Preferences Use Case"

      fill_in "Preferece", with: @preferences_use_case.preferece_id
      fill_in "Use case", with: @preferences_use_case.use_case_id
      click_on "Create Preferences use case"

      assert_text "Preferences use case was successfully created"
      click_on "Back"
    end

    test "updating a Preferences use case" do
      visit preferences_use_cases_url
      click_on "Edit", match: :first

      fill_in "Preferece", with: @preferences_use_case.preferece_id
      fill_in "Use case", with: @preferences_use_case.use_case_id
      click_on "Update Preferences use case"

      assert_text "Preferences use case was successfully updated"
      click_on "Back"
    end

    test "destroying a Preferences use case" do
      visit preferences_use_cases_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Preferences use case was successfully destroyed"
    end
  end
end
