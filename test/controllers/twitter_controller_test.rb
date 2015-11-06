require 'test_helper'

class TwitterControllerTest < ActionController::TestCase
  test "should get tweet" do
    get :tweet
    assert_response :success
  end

end
