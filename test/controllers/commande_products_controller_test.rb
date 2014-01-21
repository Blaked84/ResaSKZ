require 'test_helper'

class CommandeProductsControllerTest < ActionController::TestCase
  test "should get check_nombre" do
    get :check_nombre
    assert_response :success
  end

end
