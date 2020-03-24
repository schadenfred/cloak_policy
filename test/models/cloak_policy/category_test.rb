require 'test_helper'

module CloakPolicy

  describe Category do

    Given(:platform) { platforms(:facebook) }
    describe "sanity" do
      Then { assert_equal platform.name, 'facebook'}
    end

    Given(:subject) { Category.new }

    describe "db" do

      specify "columns" do

        must have_db_column(:name)
        must have_db_column(:category_type).of_type(:string)
        must have_db_column(:description)
        must have_db_column(:icon)
        must have_db_column(:parent_id).of_type(:integer)
        must have_db_column(:parent_type)
      end
    end

    specify "associations" do

      must belong_to(:parent).optional
    end
  end
end