require 'test_helper'

class TyperesidsControllerTest < ActionController::TestCase
  setup do
    @typeresid = typeresids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:typeresids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create typeresid" do
    assert_difference('Typeresid.count') do
      post :create, typeresid: {  }
    end

    assert_redirected_to typeresid_path(assigns(:typeresid))
  end

  test "should show typeresid" do
    get :show, id: @typeresid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @typeresid
    assert_response :success
  end

  test "should update typeresid" do
    patch :update, id: @typeresid, typeresid: {  }
    assert_redirected_to typeresid_path(assigns(:typeresid))
  end

  test "should destroy typeresid" do
    assert_difference('Typeresid.count', -1) do
      delete :destroy, id: @typeresid
    end

    assert_redirected_to typeresids_path
  end
end
