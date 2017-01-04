require 'test_helper'

class UserExperimentsControllerTest < ActionController::TestCase
  setup do
    @user_experiment = user_experiments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_experiments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_experiment" do
    assert_difference('UserExperiment.count') do
      post :create, user_experiment: { experiment: @user_experiment.experiment }
    end

    assert_redirected_to user_experiment_path(assigns(:user_experiment))
  end

  test "should show user_experiment" do
    get :show, id: @user_experiment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_experiment
    assert_response :success
  end

  test "should update user_experiment" do
    patch :update, id: @user_experiment, user_experiment: { experiment: @user_experiment.experiment }
    assert_redirected_to user_experiment_path(assigns(:user_experiment))
  end

  test "should destroy user_experiment" do
    assert_difference('UserExperiment.count', -1) do
      delete :destroy, id: @user_experiment
    end

    assert_redirected_to user_experiments_path
  end
end
