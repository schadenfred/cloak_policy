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
        Given(:vector_string)      { unscored_vector.name }
        Given(:vector_capitalized) { unscored_vector.name.to_sym }
        Given(:vector_symbol)      { unscored_vector.name.to_sym }

        describe "default must be 100" do

          Then { assert_equal record.weight_for(unscored_vector),      100 }
          And  { assert_equal record.weight_for(vector_string),        100 }
          And  { assert_equal record.weight_for(vector_capitalized),   100 }
          And  { assert_equal record.weight_for(vector_symbol),        100 }
        end

        describe "after update" do

          Given(:score) { record.scores.find_by(vector_id: vector.id) }
          Given { score.update_attribute(:weight, 90 )}

          Then { assert_equal record.weight_for(vector),    90 }
          And  { assert_equal record.weight_for('Privacy'), 90 }
          And  { assert_equal record.weight_for('privacy'), 90 }
          And  { assert_equal record.weight_for(:privacy),  90 }
        end
      end
    end
  end
end