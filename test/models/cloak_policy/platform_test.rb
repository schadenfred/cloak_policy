# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe Platform do
    Given(:subject) { Platform.new }

    describe "db" do
      specify "columns" do
        must have_db_column(:description).of_type(:string)
        must have_db_column(:icon).of_type(:string)
        must have_db_column(:fqdn).of_type(:string)
        must have_db_column(:name).of_type(:string)
        must have_db_column(:recommendable).of_type(:boolean)
        must have_db_column(:platform_type)
        wont have_db_column(:type)
      end
    end

    specify "validations" do
      must validate_presence_of(:name)
      must validate_uniqueness_of(:name).case_insensitive
    end

    specify "associations" do
      must have_many :settings
    end

    Given(:facebook) { platforms(:facebook) }
    # Given(:facebook) { splatforms(:facebook) }
    # Given(:facebook) { @platforms['facebook'] }
    # Given(:facebook) { @platforms['facebook'] }
    # Given(:facebook) { platforms(:facebook) }

    # Given(:kardashian) { recommendations(:kardashian) }

    describe "weights_for(vector)" do
      Then { assert_equal facebook.weights_for("privacy"), [20, 20] }
    end

    describe "choices_for(recommendation)" do
      # Then {
      #   assert_includes facebook.choices_for(kardashian), choices(:four)
      #   assert_includes facebook.choices_for(kardashian), choices(:one)
      #   assert_not_includes facebook.choices_for(kardashian), choices(:seven)
      # }
    end

    describe "chart-data" do
      # Given(:setting) { settings(:one) }
      # Given(:data) { facebook.chart_data("privacy") }

      # Then { assert_includes data[:labels], setting.name}
      # And  { assert_equal data[:points][0], setting.points_for(:privacy)}
      # And  { assert_equal data.size, 2 }
    end
  end
end