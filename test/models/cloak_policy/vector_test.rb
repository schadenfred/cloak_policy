# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe Vector do

    Given(:subject) { Vector.new }

    describe "db" do

      specify "columns" do

        must have_db_column(:name)
        must have_db_column(:description)
        must have_db_column(:icon)
        must have_db_column(:parent_id).of_type(:integer)
      end
    end

    describe "associations" do

      specify "belongs_to" do

        must belong_to(:parent).optional
      end

      specify "has_many" do
        
        must have_many(:intents)
        must have_many(:scored)
        must have_many(:scores)
        must have_many(:scored_settings)
        must have_many(:subvectors)
      end
    end

    Given(:vector) { vectors(:privacy)}
    Given(:subvector) { vectors(:location)}
    Given(:bottom_vector) { vectors(:geolocation)}

    describe "newly created vector" do

      Given(:new_vector) { Vector.last }

      describe "must create a new score with itself as its own vector" do

        Given(:action) { Vector.create(name: 'sharing')}

        Then { assert_difference(['Score.count'] ) { action } }
        And  { assert_equal new_vector.name, 'sharing'}
        And  { assert_equal new_vector.scores.last.vector, new_vector }
      end

      describe "newly created subvector" do

        Given(:action) { vector.subvectors.create(name: 'presence') }

        Then { assert_difference(['Score.count'] ) { action } }
        And  { assert_equal new_vector.name, 'presence'}
        And  { assert_equal new_vector.scores.last.vector, vector }
        And  { assert_includes vector.subvectors, new_vector  }
      end
    end

    describe "scopes" do

      describe ":top_level" do

        Then { assert Vector.top_level.include? vector }
        And  { refute Vector.top_level.include? subvector }
        And  { assert vector.subvectors.include? subvector }
      end

      describe ":bottom_level" do

        Then {
          assert_equal vector.bottom_level?, false
          assert_equal subvector.bottom_level?, false
          assert_equal bottom_vector.bottom_level?, true
          assert_includes Vector.bottom_level, bottom_vector
        }
      end
    end

    describe ":full_name" do

      Then { assert_equal vector.full_name, vector.name }
    end

    describe ":settings" do

      describe "must return settings scored for the vector" do 
                
        Then { assert_equal scores(:four).vector, vectors(:geolocation) } 
        And  { assert_includes vectors(:geolocation).scored, scores(:four) }
        And  { assert_includes vectors(:geolocation).scored_settings, settings(:two) }
        And  { assert_includes vectors(:geolocation).child_settings, settings(:two) }
      end

      describe "must return settings for the bottom level subvector" do

        Then { assert_includes vectors(:location).child_settings, settings(:two) }
      end

      describe "must return all settings for all the bottom level subvectors" do

        Then { assert_includes vectors(:privacy).child_settings, settings(:two) }
      end
    end

    describe "intent_options_count" do 
      
      describe "bottom level vector with settings" do 
      
        Then { assert_equal 2, vectors(:geolocation).intent_options_count }
      end
      
      describe "subvector" do 
        
        Then { assert_equal 2, vectors(:location).intent_options_count }
      end
      
      describe "top level vector with a setting with more than 2 choices" do 
        
        Then { assert_equal 3, vectors(:privacy).intent_options_count }
      end
    end
  end
end