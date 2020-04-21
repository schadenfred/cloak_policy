require 'test_helper'

module CloakPolicy

  class ScorableTest < ActiveSupport::TestCase

    Given(:choice)                   { choices(:one) }
    Given(:platform)                 { platforms(:facebook) }
    Given(:setting)                  { settings(:one) }
    Given(:vector)                   { vectors(:privacy) }

    scorables = %w( vector choice platform setting  )

    scorables.each do |scorable|

      klass = "CloakPolicy::#{scorable.capitalize}".classify.constantize

      Given(:subject) { klass.new }
      Given(:record) { eval(scorable)}

      specify "associations" do
        must have_many :scores
      end

      describe "#{scorable}:weight_for(:vector)" do

        Given(:unscored_vector)    { vectors(:unscored_vector) }

        describe "default must be 100" do

          Then { assert_equal record.weight_for(unscored_vector.id),      100 }
        end

        describe "after update" do

          Given(:score) { record.scores.find_by(vector_id: vector.id) }
          Given { score.update_attribute(:weight, 90 )}

          Then { assert_equal record.weight_for(vector.id),    90 }
        end
      end
    end
  end
end