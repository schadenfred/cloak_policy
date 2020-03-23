require "application_system_test_case"

module CloakPolicy
  class CategoriesTest < ApplicationSystemTestCase
    setup do
      @category = cloak_policy_categories(:one)
    end

    test "visiting the index" do
      visit categories_url
      assert_selector "h1", text: "Categories"
    end

    test "creating a Category" do
      visit categories_url
      click_on "New Category"

      fill_in "Category type", with: @category.category_type
      fill_in "Description", with: @category.description
      fill_in "Icon", with: @category.icon
      fill_in "Name", with: @category.name
      fill_in "Parent", with: @category.parent_id
      fill_in "Parent type", with: @category.parent_type
      fill_in "Row order", with: @category.row_order
      fill_in "Type", with: @category.type
      click_on "Create Category"

      assert_text "Category was successfully created"
      click_on "Back"
    end

    test "updating a Category" do
      visit categories_url
      click_on "Edit", match: :first

      fill_in "Category type", with: @category.category_type
      fill_in "Description", with: @category.description
      fill_in "Icon", with: @category.icon
      fill_in "Name", with: @category.name
      fill_in "Parent", with: @category.parent_id
      fill_in "Parent type", with: @category.parent_type
      fill_in "Row order", with: @category.row_order
      fill_in "Type", with: @category.type
      click_on "Update Category"

      assert_text "Category was successfully updated"
      click_on "Back"
    end

    test "destroying a Category" do
      visit categories_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Category was successfully destroyed"
    end
  end
end
