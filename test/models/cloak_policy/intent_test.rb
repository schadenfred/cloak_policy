require 'test_helper'

module CloakPolicy

  describe Intent do 
    Given(:subject) { Intent.new }

    describe "db" do

      specify "columns" do
        # must have_db_column(:impact).of_type(:string)
        # must have_db_column(:scorable_id).of_type(:integer)
        # must have_db_column(:scorable_type)
        # must have_db_column(:vector_id).of_type(:integer)
        # must have_db_column(:weight).of_type(:integer)
      end
    end

    specify "associations" do
      # must belong_to :vector
      # must belong_to :scorable
    end


  end

end
