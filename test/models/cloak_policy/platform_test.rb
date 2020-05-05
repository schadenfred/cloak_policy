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
  end
end