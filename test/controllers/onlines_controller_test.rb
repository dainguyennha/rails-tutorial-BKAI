require 'test_helper'

class OnlinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get onlines_index_url
    assert_response :success
  end

end
