# frozen_string_literal: true

require "test_helper"

describe RecommendationsUseCase do
  Given(:subject) { RecommendationsUseCase.new }

  describe "db" do
    specify "columns" do
      must have_db_column(:recommendation_id).of_type(:integer)
      must have_db_column(:use_case_id).of_type(:integer)
    end
  end

  specify "associations" do
    must belong_to :recommendation
    must belong_to :use_case
  end
end
