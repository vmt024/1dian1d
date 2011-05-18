require 'test_helper'

class ProjectUpdatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_updates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_update" do
    assert_difference('ProjectUpdate.count') do
      post :create, :project_update => { }
    end

    assert_redirected_to project_update_path(assigns(:project_update))
  end

  test "should show project_update" do
    get :show, :id => project_updates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => project_updates(:one).to_param
    assert_response :success
  end

  test "should update project_update" do
    put :update, :id => project_updates(:one).to_param, :project_update => { }
    assert_redirected_to project_update_path(assigns(:project_update))
  end

  test "should destroy project_update" do
    assert_difference('ProjectUpdate.count', -1) do
      delete :destroy, :id => project_updates(:one).to_param
    end

    assert_redirected_to project_updates_path
  end
end
