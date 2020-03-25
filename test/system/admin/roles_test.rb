require "application_system_test_case"

class RolesTest < ApplicationSystemTestCase

  Given(:admin) { users(:site_admin)}
  Given { signin :site_admin }
  Given(:user) { users(:one) }

  describe "creating a Category" do

    Given do
      visit users_url

      click_link('Show', href: "/users/#{user.id}")

      # fill_in "Description", with: category.description
      # fill_in "Icon", with: category.icon
      # fill_in "Name", with: category.name
      # click_on "Create Category"
    end

    # Then { save_and_open_page}
  end
end
