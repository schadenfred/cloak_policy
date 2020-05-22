require 'test_helper'

module CloakPolicy
 
  describe Intent do 

    Given(:subject) { Intent.new }

    describe "db" do 

      specify "columns" do 

        must have_db_column(:name).of_type(:string)
        must have_db_column(:description).of_type(:text)
        must have_db_column(:weight).of_type(:integer)
        must have_db_column(:vector_id).of_type(:integer)
      end

      specify "associations" do 

        must belong_to :vector
      end
    end
  end
end
