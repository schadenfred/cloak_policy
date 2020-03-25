require "application_system_test_case"

class UseCasesTest < ApplicationSystemTestCase

  Given(:profile) { profiles(:executive) }
  Given(:use_case) { use_cases(:business) }
  Given(:preference) { preferences(:posts_frequently) }

  Given { sign_in_admin }
  Given { visit admin_profile_path(profile.id) }

  describe "profile use cases" do

    describe "must render form for new use case" do

      Then { assert page.has_field?('Name') }
      And  { assert page.has_field?('Icon') }
      And  { assert page.has_field?('Description') }
    end

    describe "must create use case for a profile" do

      Given(:uc_name) { 'Reach shareholders' }
      Given { fill_in 'Name', with: uc_name }
      Given { click_button 'Create Use Case' }

      Then { assert_includes profile.use_cases.pluck(:name), uc_name }
    end

    describe "must update attributes of existing use case" do

      Given {  click_link(use_case.name) }

      describe "form must indicate profile" do

        Then { assert page.has_current_path? edit_admin_use_case_path(use_case) }
        And  { assert page.has_content?("Profile: #{profile.name}") }
      end

      describe "form submit must update" do

        Given { fill_in 'Name', with: "New name" }
        Given { click_button 'Update Use case' }

        Then { assert_equal use_case.reload.name, "New name"}
        And { assert page.has_current_path? edit_admin_use_case_path(use_case) }
      end
    end

    describe "must edit adjust preferences use case" do

      Given {  click_link(use_case.name) }

      describe "form submit must update" do

        Given { check preference.name }
        Given { click_button 'Update Preferences' }

        Then { assert_includes use_case.preferences, preference }
        And { assert page.has_current_path? edit_admin_use_case_path(use_case)  }
      end
    end

    describe "select default recommendation" do

      Given { click_link(use_case.name) }
      Given { page.find(id: 'defaultRecommendation').select 'kardashian' }
      Given { click_button 'Select Default Recommendation' }
      Then { assert_equal use_case.default_recommendation.name, 'kardashian' }
    end
  end
end
