require 'test_helper'

class StartControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get start_top_url
    assert_response :success
  end

end
