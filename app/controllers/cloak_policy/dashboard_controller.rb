# frozen_string_literal: true
module CloakPolicy
  class DashboardController < ApplicationControllerr
    def show
      @settings = Setting.all
      @platforms = Platform.all
      @pack = current_user.invitations
    end
  end
end