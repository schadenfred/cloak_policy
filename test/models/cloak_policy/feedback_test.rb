# frozen_string_literal: true

require "test_helper"

describe Feedback do
  Given(:subject) { Feedback.new }

  describe "db" do
    specify "columns" do
      must have_db_column(:content)
      must have_db_column(:reasons).of_type(:text)
    end
  end
end
