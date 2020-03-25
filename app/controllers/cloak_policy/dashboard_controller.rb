# frozen_string_literal: true
require_dependency "cloak_policy/application_controller"

module CloakPolicy
  class DashboardController < ApplicationController
    def show
      @settings = Setting.all
      @platforms = Platform.all
    end
  end
end