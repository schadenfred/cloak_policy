# frozen_string_literal: true

require "test_helper"

describe Preference do
  Given(:subject) { Preference.new }

  specify "associations" do
    must have_many(:preferences_recommendations)
    must have_many(:preferences_use_cases)
    must have_many(:recommendations)
    must have_many(:scores)
    must have_many(:use_cases)
  end
end
