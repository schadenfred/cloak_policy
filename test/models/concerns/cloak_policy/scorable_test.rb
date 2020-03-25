require 'test_helper'

module CloakPolicy

  class ScorableTest < ActiveSupport::TestCase

    Given(:choice)                   { choices(:one) }
    Given(:chosen)                   { chosens(:one) }
    Given(:preference)               { preferences(:posts_frequently) }
    Given(:platform)                 { platforms(:facebook) }
    Given(:setting)                  { settings(:one) }
    Given(:vector)                   { vectors(:privacy) }

    # scorables = %w(choice preference platform setting)
    scorables = %w( platform)

    scorables.each do |scorable|

      klass = "CloakPolicy::#{scorable.capitalize}".classify.constantize

      Given(:subject) { klass.new }
      Given(:record) { eval(scorable)}

      specify "associations" do

        must have_many :scores
      end

      describe "#{scorable}:points_for(:vector)" do

        describe "default must be 0" do
Given { skip }
          Then { assert_equal record.points_for(:privacy), 20 }
          And  { assert_equal record.points_for(vector), 20 }
          And  { assert_equal chosen.points_for(:privacy), 1 }
        end

      #   describe "after update" do

      #     Given(:score) { record.scores.find_by(vector_id: vector.id) }
      #     Given { score.update_attribute(:points, 90 )}

      #     Then { assert_equal record.points_for(:privacy), 90 }
      #     And  { assert_equal chosen.points_for(:privacy), 4 }
      #   end
      end
    end

    describe "recommendation" do

      # Given do
      #   recommendation.recommendations_platforms.each do |rs|
      #     score = rs.scores.find_by(vector_id: vector.id)
      #     score.update(points: 40)
      #   end
      # end

      # describe ".point_total_for" do

      #   Then { assert_equal recommendation.point_total_for(:privacy), 120 }
      # end

      # describe ".share_for(platform, vector)" do

      #   Given { assert_equal recommendation.share_for(:privacy, recommendations_platform.platform), 33 }
      #   Given { recommendations_platform.scores.first.update(points: 10 ) }

      #   Then {
      #     assert_equal recommendation.share_for(:privacy, recommendations_platform.platform), 11 }
      # end
    end

    describe "chosen" do

      # describe ":points_for(:vector)" do

      #   Given {
      #     rs = recommendations_platforms(:one)
      #     rs.scores.find_by(vector_id: vector.id).update(points: 400)
      #     setting.scores.find_by(vector_id: vector.id).update(points: 25)
      #     choice.scores.find_by(vector_id: vector.id).update(points: 70) }

      #   Then { assert_equal chosen.points_for(:privacy), 70 }
      # end
    end
  end
end