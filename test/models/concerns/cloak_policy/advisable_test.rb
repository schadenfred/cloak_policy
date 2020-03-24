require 'test_helper'

module CloakPolicy

  class AdvisableTest < ActiveSupport::TestCase

    Given(:platform) { platforms(:facebook) }
    Given(:setting) { settings(:one) }
    Given(:choice)  { choices(:one) }
    Given(:chosen)  { chosens(:one)}
    Given(:theirs)  { "their text" }
    Given(:ours)    { "our text" }


    describe "shared behavior of Platform, Setting, and Choice models" do

      %w[platform setting choice].each do |m|

        klass = ("CloakPolicy::#{m.capitalize}").classify.constantize

        describe klass do

          Given(:subject) { klass.new }
          Given(:fixture) { eval(m)}

          describe "db" do

            specify "columns" do

              unless m.eql?('chosen')

                must have_db_column(:they_say)
                must have_db_column(:we_say)
              end
            end
          end

          describe "descriptions" do

            Given(:theirs) { "their description" }
            Given(:ours)   { "our description" }

            describe "#they_say" do

              Given { fixture.update(they_say: theirs)}

              Then { assert_equal fixture.they_say, theirs }
              And  { assert_equal fixture.we_say, theirs }
            end

            describe "#we_say" do

              Given { fixture.update(we_say: ours)}

              Then { assert_equal fixture.we_say, ours }
            end
          end
        end
      end
    end

#     describe "cascading advice" do

#       describe "default" do

#         # Then { assert_equal platform.they_say, platform.name }
#         # And  { assert_equal platform.we_say, platform.name }
#         # And  { assert_equal setting.they_say, setting.name }
#         # And  { assert_equal setting.we_say, setting.name }
#         # And  { assert_equal choice.they_say, setting.name }
#         # And  { assert_equal chosen.advice, setting.name }
#       end

#       describe "setting :they_say" do

#         Given { setting.update(they_say: theirs)}

#         # Then { assert_equal setting.we_say, theirs }
#         # And  { assert_equal choice.they_say, theirs }
#         # And  { assert_equal choice.we_say, theirs }
#         # And  { assert_equal chosen.advice, theirs }
#       end

#       describe "setting :we_say" do

#         Given { setting.update(they_say: theirs)}
#         Given { setting.update(we_say: ours)}

#         # Then { assert_equal setting.we_say, ours }
#         # And  { assert_equal choice.they_say, theirs }
#         # And  { assert_equal choice.we_say, theirs }
#         # And  { assert_equal chosen.advice, theirs }
#       end

#       describe "choice :they_say" do

#         Given { setting.update(we_say: ours)}
#         Given { choice.update(they_say: theirs)}

#         # Then { assert_equal choice.they_say, theirs }
#         # And  { assert_equal choice.we_say, theirs }
#         # And  { assert_equal chosen.advice, theirs }
#       end

#       describe "choice :we_say" do

#         Given { choice.update(they_say: theirs)}
#         Given { choice.update(we_say: ours)}

#         # Then { assert_equal choice.they_say, theirs }
#         # And  { assert_equal choice.we_say, ours }
#         # And  { assert_equal chosen.advice, ours }
#       end

#       describe "chosen :we_say" do

#         Given { choice.update(they_say: theirs)}
#         Given { chosen.update(advice: ours)}

#         # Then { assert_equal choice.we_say, theirs }
#         # And  { assert_equal chosen.they_say, theirs }
#         # And  { assert_equal chosen.advice, ours }
#       end
#     end
  end
end