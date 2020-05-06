# frozen_string_literal: true

require "test_helper"

module CloakPolicy

  describe Recommendation do
    Given(:subject) { Recommendation.new }

    describe "db" do
      specify "columns" do
        must have_db_column(:name)
        must have_db_column(:description)
        must have_db_column(:recommender_id).of_type(:integer)
      end
    end

    describe "associations" do

      specify "has_many" do
        must have_many :chosens
      end
    end
  end 
end