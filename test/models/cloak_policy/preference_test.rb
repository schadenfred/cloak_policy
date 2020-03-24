# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe Preference do

    Given(:subject) { Preference.new }

    specify "associations" do

      must have_many(:preferences_use_cases)
      must have_many(:scores)
      must have_many(:use_cases)
    end
  end
end