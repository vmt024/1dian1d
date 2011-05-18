require 'test_helper'

class ProjectPrizesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_prizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_prize" do
    assert_difference('ProjectPrize.count') do
      post :create, :project_prize => { }
    end

    assert_redirected_to project_prize_path(assigns(:project_prize))
  end

  test "should show project_prize" do
    get :show, :id => project_prizes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => project_prizes(:one).to_param
    assert_response :success
  end

  test "should update project_prize" do
    put :update, :id => project_prizes(:one).to_param, :project_prize => { }
    assert_redirected_to project_prize_path(assigns(:project_prize))
  end

  test "should destroy project_prize" do
    assert_difference('ProjectPrize.count', -1) do
      delete :destroy, :id => project_prizes(:one).to_param
    end

    assert_redirected_to project_prizes_path
  end
end
