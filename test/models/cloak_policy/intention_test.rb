require 'test_helper'

module CloakPolicy
  
  describe Intention do 

    Given(:subject) { Intention.new }

    describe "db" do 

      specify "columns" do 

        must have_db_column(:intent_id).of_type(:integer)
        must have_db_column(:intendable_id).of_type(:integer)
        must have_db_column(:intendable_type).of_type(:string)
      end 
    end

    describe "associations" do 

      specify "belongs_to" do 
        must belong_to(:intendable)
        must belong_to(:intent)
      end
    end
  end
end
