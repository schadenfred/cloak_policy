require "application_system_test_case"

class VectorsTest < ApplicationSystemTestCase

  Given(:vector) { vectors(:privacy) }
  Given { sign_in }
  Given { visit admin_vectors_path }

  describe "/vectors" do

    describe "must list current vectors" do

      Then { assert page.has_content?(vector.name) }
    end

    describe "vector names must link to edit" do

      Then  { assert page.has_link?(vector.name) }
    end

    describe "must have link to new vector" do

      Then { assert page.has_link?('New vector') }
    end
  end

  describe "edit vector" do

    Given { visit edit_vector_path(vector.id)  }

    Then { assert page.has_field?('Name') }
    And  { assert page.has_field?('Icon') }
    And  { assert page.has_field?('Description') }

    describe "update vector" do

      Given { fill_in 'Name', with: 'Le Privacy' }
      Given { click_button 'Update Vector' }

      Then { assert_equal vector.reload.name, 'Le Privacy' }
      And  { assert page.has_current_path?(admin_vectors_path)  }
      And  { assert page.has_link?(vector.name) }
    end
  end

  describe "create vector" do

    Given { click_link 'New vector' }
    Given { fill_in 'Name', with: 'Stalkability' }
    Given { click_button 'Create Vector' }

    Then { assert page.has_current_path?(admin_vectors_path)  }
    And  { refute_nil Vector.find_by(name: "Stalkability") }
    And  { assert page.has_link?('Stalkability') }
  end
end
