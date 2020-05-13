require 'test_helper'

module CloakPolicy

  class ConfigurableTest < ActiveSupport::TestCase

    Given(:subject) { CloakPolicy::Configurable.new }

    describe "flare" do

      Given(:json) { subject.flare }

      Then { assert_equal json[:name], 'Cloak' }

    end

    describe "descendants" do 
      
      Given(:descendants) { subject.descendants }
      Then { 
        assert_equal subject.descendants[0][:name], 'privacy'
      #   assert_equal subject.descendants[0][:child_type], 'vector'
      #   # assert_equal subject.descendants[0][:intent], 'least'
      #   # assert_equal subject.descendants[0][:children][0][:name], 'least'
      #   assert_equal subject.descendants[0][:children][0][:children][0][:name], 'location'
      #   # assert_equal subject.descendants[0][:children][0][:children][0][:children][0][:name], 'off'
      #   assert_equal subject.descendants[0][:children][0][:children][0][:children][0][:children][0][:name], 'geolocation'
      #   # assert_equal subject.descendants[0][:children][0][:children][0][:children][0][:children][0][:children][0][:name], 'off'
      }                                                                                                                                                                                                                                                  

      # # And  { assert_equal subject.descendants[0][:children][0][:name], 'location'}
      # # And  { assert_equal subject.descendants[0][:children][0][:children][0][:name], 'geolocation'}
      # # And  { assert_equal subject.descendants[0][:children][0][:children][0][:children][0][:name], settings(:two).name}
      # # And  { assert_equal subject.descendants[0][:children][0][:children][0][:children][0][:children][0][:name], choices(:four).name}
    end

    describe "intent_options(vector)" do 
      
      describe "bottom level vector with settings" do 
      
        Then { assert_equal ["off", "on"], subject.intent_options(vectors(:geolocation))}
      end
      
      describe "subvector" do 
        
        Then { assert_equal ["off", "on"], subject.intent_options(vectors(:location))}
      end
      
      describe "top level vector with a setting with more than 2 choices" do 
        
        Then { assert_equal %w(least middle most), subject.intent_options(vectors(:privacy))}
      end
    end
  end
end