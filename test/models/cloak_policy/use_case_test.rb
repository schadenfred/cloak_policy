# frozen_string_literal: true

require "test_helper"

describe UseCase do
  Given(:subject) { UseCase.new }

  describe "associations" do
    specify "belongs_to" do
      must belong_to :profile
    end

    specify "has_one" do
      must have_one(:default_recommendation).through(:recommendations_use_case)
      must have_one :recommendations_use_case
    end

    specify "has_many" do
      must have_many :preferences_use_cases
      must have_many :preferences
    end
  end

  describe "default_recommendation" do
    Given(:use_case) { use_cases(:business) }
    Given(:recommendation) { recommendations(:kardashian) }
    Then { assert_equal use_case.default_recommendation, recommendation }
  end
end
