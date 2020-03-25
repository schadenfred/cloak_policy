# require 'test_helper'

# class ProfilesControllerTest < ActionDispatch::IntegrationTest

#   Given(:profile) { profiles(:executive) }
#   Given { sign_in }

#   describe "PATCH update" do

#     Given(:params) {{"profile" => {use_cases_attributes: [{name: "trolling"}]}}}
#     Given(:request) { patch admin_profile_url(profile), params: params }

#     describe "must change attrs" do

#       Then { assert_difference(['UseCase.count'], 1) { request } }

#       And { assert_equal UseCase.last.name, "trolling" }
#     end
#   end
# end
