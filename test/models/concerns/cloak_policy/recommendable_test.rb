require 'test_helper'

module CloakPolicy

  class RecommendableTest < ActiveSupport::TestCase

    Given(:platform)        { platforms(:facebook) }
    Given(:setting)        { settings(:one) }
    Given(:choice)         { choices(:one) }

    describe "sloppy?" do

      Given { Setting.all.each { |s| s.activate!} }
      Given { Choice.all.each { |c| c.activate! } }

      describe "platform" do

        describe "when all settings recomendable" do

          Then { refute platform.sloppy? }
        end

        describe "when one or more settings not recomendable" do

          Given { setting.deactivate! }

          Then { assert platform.sloppy? }
        end

        describe "when one or more choices not recomendable" do

          Given { choice.deactivate! }

          Then { assert platform.sloppy? }
        end
      end

      describe "setting" do

        describe "when all choices recomendable" do

          Then { refute setting.sloppy? }
        end

        describe "when one or more choices not recomendable" do

          Given { choice.deactivate! }

          Then { assert setting.sloppy? }
        end
      end
    end

    describe "recommendables" do

      # describe "recommendation" do

        # describe "when platform recommendable and selected" do

        #   Then { assert_includes recommendation.recommendables, platform }
        # end

#         describe "when platform recomme
#         ndable but not selected" do

#           Given {
#             rss = recommendation.recommendations_platforms
#             rss.find_by(platform_id: platform.id ).destroy }

#           Then { refute_includes recommendation.recommendables, platform }
#         end

#         describe "when platform not recommendable" do

#           Given { platform.deactivate!}

#           Then { refute_includes recommendation.recommendables, platform }
#         end
      # end

      describe "platform" do

        describe "when setting recommendable" do

          Then { assert_includes platform.recommendables, setting }
        end

        describe "when setting not recommendable" do

          Given { setting.deactivate! }

          Then { refute_includes platform.recommendables, setting }
        end
      end

      describe "setting" do

        describe "when choice recommendable" do

          Then { assert_includes setting.recommendables, choice }
        end

        describe "when choice not recommendable" do

          Given { choice.deactivate! }

          Then { refute_includes setting.recommendables, choice }
        end
      end
    end

    describe "shared behavior of Platform, Setting, and Choice models" do

      %w[platform setting choice].each do |m|

        klass = ("CloakPolicy::#{m.capitalize}").classify.constantize

        describe klass do

          Given(:subject) { klass.new }
          Given(:fixture) { eval(m)}

          describe "db" do

            specify "columns" do

              must have_db_column(:recommendable).of_type(:boolean)
            end
          end

          describe "newly instantiated" do

            Then { refute subject.recommendable }
          end

          describe "fixtures" do

            describe "default" do

              Then { assert fixture.recommendable? }
              And  { assert fixture.recommendable }
            end

            describe "deactivation" do

              Given { fixture.deactivate! }

              Then { refute fixture.recommendable }
              And  { refute fixture.recommendable? }

              describe "activation" do

                Given { fixture.activate! }

                Then { assert fixture.recommendable }
              end
            end
          end
        end
      end
    end

    describe "cascading deactivation" do

      describe "platform.setting.parent_recommendable? must return true" do

        Then { assert setting.parent_recommendable? }
      end

      describe "of platform" do

        Given { platform.deactivate! }

        describe "makes setting.parent_recommendable? return false" do

          Then { refute setting.parent_recommendable? }
        end

        describe "leaves settings and choices" do

          describe ":recommendable" do

            Then { refute platform.recommendable }
            And  { assert setting.recommendable }
            And  { assert choice.recommendable }
          end

          describe "but not :recommendable?" do

            Then { refute platform.recommendable? }
            And  { refute setting.recommendable? }
            And  { refute choice.recommendable? }
          end
        end
      end

      describe "choices.first.parent_recommendable? must return true" do

        Then { assert choice.parent_recommendable? }
      end

      describe "of setting" do

        Given { setting.deactivate! }

        Then { refute setting.recommendable }
        And  { assert choice.recommendable }
        And  { refute choice.recommendable? }

        describe "setting.choices.first.parent_recommendable? return false" do

          Then { refute setting.choices.first.parent_recommendable? }
        end
      end

      describe "of choice" do

        Given { choice.deactivate! }

        Then { refute choice.recommendable }
        And  { refute choice.recommendable? }
      end
    end
  end
end