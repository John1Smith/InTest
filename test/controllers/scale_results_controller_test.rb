require 'test_helper'

class ScaleResultsControllerTest < ActionController::TestCase
  setup do
    @scale_result = scale_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scale_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scale_result" do
    assert_difference('ScaleResult.count') do
      post :create, scale_result: { result: @scale_result.result, scale_id: @scale_result.scale_id, user_id: @scale_result.user_id }
    end

    assert_redirected_to scale_result_path(assigns(:scale_result))
  end

  test "should show scale_result" do
    get :show, id: @scale_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scale_result
    assert_response :success
  end

  test "should update scale_result" do
    patch :update, id: @scale_result, scale_result: { result: @scale_result.result, scale_id: @scale_result.scale_id, user_id: @scale_result.user_id }
    assert_redirected_to scale_result_path(assigns(:scale_result))
  end

  test "should destroy scale_result" do
    assert_difference('ScaleResult.count', -1) do
      delete :destroy, id: @scale_result
    end

    assert_redirected_to scale_results_path
  end
end
