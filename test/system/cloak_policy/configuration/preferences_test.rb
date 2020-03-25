require "application_system_test_case"

class PreferencesTest < ApplicationSystemTestCase

  Given(:preference) { preferences(:posts_frequently) }
  Given { sign_in }
  Given { visit admin_preferences_path }

  describe "/admin/preferences" do

    describe "must list current preferences" do

      Then { assert page.has_content?(preference.name) }
    end

    describe "preference names must links to edit" do

      Then  { assert page.has_link?('Edit', href: edit_preference_path(preference)) }
    end

    describe "must have link to new preference" do

      Then { assert page.has_link?('New preference') }
    end
  end

  describe "edit preference" do

    Given { click_link('Edit', href: edit_preference_path(preference) ) }

    Then { assert page.has_field?('Name') }
    And  { assert page.has_field?('Icon') }
    And  { assert page.has_field?("preference[description]") }

    describe "update preference" do

      Given { fill_in 'Name', with: 'Likes big people' }
      Given { fill_in 'Icon', with: 'some_icon' }
      Given { fill_in "preference[description]", with: 'some text' }
      Given { click_button 'Update Preference' }
      Given { preference.reload }

      Then { assert_equal preference.name, 'Likes big people' }
      And  { assert_equal preference.icon, 'some_icon' }
      And  { assert_equal preference.description, 'some text' }
      And  { assert page.has_current_path?(admin_preferences_path)  }
    end
  end

  describe "create preference" do

    Given { click_link 'New preference' }
    Given { fill_in 'Name', with: 'Dislikes being tracked' }
    Given { click_button 'Create Preference' }

    # Then { assert page.has_current_path?(preferences_path)  }
    # And  { assert Preference.find_by(name: "Dislikes being tracked") }
  end
end