require 'test_helper'

class LitsControllerTest < ActionController::TestCase
  setup do
    @lit = lits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lit" do
    assert_difference('Lit.count') do
      post :create, lit: { chambre_id: @lit.chambre_id, name: @lit.name, personne_id: @lit.personne_id }
    end

    assert_redirected_to lit_path(assigns(:lit))
  end

  test "should show lit" do
    get :show, id: @lit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lit
    assert_response :success
  end

  test "should update lit" do
    patch :update, id: @lit, lit: { chambre_id: @lit.chambre_id, name: @lit.name, personne_id: @lit.personne_id }
    assert_redirected_to lit_path(assigns(:lit))
  end

  test "should destroy lit" do
    assert_difference('Lit.count', -1) do
      delete :destroy, id: @lit
    end

    assert_redirected_to lits_path
  end
end
