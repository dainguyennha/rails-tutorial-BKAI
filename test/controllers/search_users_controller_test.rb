require 'test_helper'

class SearchUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get search_users_create_url
    assert_response :success
  end

end
