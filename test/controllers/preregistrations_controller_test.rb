require 'test_helper'

class PreregistrationsControllerTest < ActionController::TestCase
  setup do
    @preregistration = preregistrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preregistrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preregistration" do
    assert_difference('Preregistration.count') do
      post :create, preregistration: {  }
    end

    assert_redirected_to preregistration_path(assigns(:preregistration))
  end

  test "should show preregistration" do
    get :show, id: @preregistration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preregistration
    assert_response :success
  end

  test "should update preregistration" do
    patch :update, id: @preregistration, preregistration: {  }
    assert_redirected_to preregistration_path(assigns(:preregistration))
  end

  test "should destroy preregistration" do
    assert_difference('Preregistration.count', -1) do
      delete :destroy, id: @preregistration
    end

    assert_redirected_to preregistrations_path
  end
end
