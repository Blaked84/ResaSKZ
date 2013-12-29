require 'test_helper'

class ProductControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
