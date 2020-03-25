require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase

  Given(:profile) { profiles(:executive) }

  Given { visit admin_profiles_path }

  describe "admin/profiles" do

    describe "must list current profiles" do

      Then { within('table') { assert page.has_content?(profile.name) } }
    end

    describe "profile names must links to edit" do

      Then  { within('table') { assert page.has_link?('Edit') } }
    end

    describe "must have link to new profile" do

      Then { assert page.has_link?('New profile') }
    end
  end

  describe "edit profile" do

    Given { within('table') {
      click_link('Edit', href: edit_admin_profile_path(profile)) }}

    Then { assert page.has_field?('Name') }
    And  { assert page.has_field?('Icon') }
    And  { assert page.has_field?('Description') }

    describe "update profile" do

      Given { fill_in 'Name', with: 'Le CEO' }
      Given { click_button 'Update Profile' }

      Then { assert_equal profile.reload.name, 'Le CEO' }
      And  { assert page.has_current_path?(admin_profile_path(profile))  }
    end
  end

  describe "create profile" do

    Given { click_link 'New profile' }
    Given { fill_in 'Name', with: 'Janitor' }
    Given { click_button 'Create Profile' }
    Given(:newprofile) { Profile.find_by(name: "Janitor") }

    Then { refute_nil newprofile }
    And  { assert page.has_current_path?(admin_profiles_path)  }
    And  { within('.table-striped') { assert page.has_link?('Janitor')}}
  end
end
