# frozen_string_literal: true

require "test_helper"

describe RecommendationsPlatform do
  Given(:subject) { RecommendationsPlatform.new }

  describe "db" do
    specify "columns" do
      must have_db_column(:recommendation_id).of_type(:integer)
      must have_db_column(:platform_id).of_type(:integer)
    end
  end

  specify "associations" do
    must belong_to :recommendation
    must belong_to :platform
    must have_many :scores
    must have_many :vectors
  end
end
