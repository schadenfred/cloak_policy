# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe UseCase do

    Given(:subject) { UseCase.new }

    describe "associations" do

      specify "belongs_to" do
        must belong_to :profile
      end

      specify "has_many" do
        must have_many :preferences_use_cases
        must have_many :preferences
      end
    end
  end
end