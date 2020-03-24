# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe Profile do

    Given(:subject)  { Profile.new }

    specify "associations" do
      must have_many :use_cases
    end
  end
end