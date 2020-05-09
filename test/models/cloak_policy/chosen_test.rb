require 'test_helper'

module CloakPolicy

  describe Chosen do

    Given(:subject) { Chosen.new }

    describe "db" do

      specify "columns" do

        must have_db_column(:advice)
        must have_db_column(:choice_id).of_type(:integer)
        must have_db_column(:recommendation_id).of_type(:integer)
      end
    end

    specify "associations" do

      must belong_to :choice 
      must belong_to :recommendation 
    end

    describe "must provide name and value of choice" do 
      Given(:chosen) { chosens(:one) }
      Given(:choice) { chosen.choice }
      
      Then { 
        assert_equal chosen.choice.name, choice.name
        assert_equal chosen.choice.value, choice.value
        assert_equal chosen.name, choice.name
        assert_equal chosen.value, choice.value 
      }

    end
    # describe "must be destroyed if reccommendation is destroyed" do

    #   Given(:count) { recommendation.chosens.count }

    #   Then { assert_difference('Chosen.count', -count) { recommendation.destroy }}
    # end

    # describe "platform" do

    #   Then { assert_equal chosen.platform, chosen.setting.platform}
    # end

    # describe "position" do

    #   Given(:expected) { chosen.choice.setting.row_order_rank }

    #   Then { assert_equal chosen.position, expected }
    # end

    # describe "validations" do

    #   specify "presence" do

    #     must validate_presence_of(:choice)
    #     must validate_presence_of(:recommendation)
    #     must validate_presence_of(:setting)
    #   end

    #   specify "uniqueness" do

    #     must validate_uniqueness_of(:choice_id).scoped_to(:recommendation_id)
    #   end
    # end

    # describe ":impact" do

    #   Given(:one) { chosens(:one) }
    #   Given(:two) { chosens(:four) }
    #   Given(:three) { chosens(:five) }
    #   Given(:vector) { vectors(:privacy) }

    #   Given(:points) { {
    #     "recommendations_platforms(:one)" => 1000,
    #     "one.choice.setting" => 80,
    #     "one.choice" => 70,
    #     "two.choice" => 100,
    #     "three.choice" => 50 } }

    #   Given do
    #     Score.destroy_all
    #     points.each do |k, v|
    #       score = eval(k).scores.where(vector_id: vector.id).first_or_initialize
    #       score.update(points:  v)
    #     end
    #   end

    #   describe ":siblings" do

    #     Then {
    #       refute_includes one.siblings, one.choice
    #       assert_includes one.siblings, two.choice
    #       assert_includes one.siblings, three.choice }
    #   end

    #   describe ".delta_for(choice, vector)score" do

    #     Then { assert_equal chosen.points_for(vector), 560 }
    #     And { assert_equal one.delta_for(two.choice, vector), "Reduces your #{vector.name.downcase} by 240 points." }
    #   end
    # end
  end
end 