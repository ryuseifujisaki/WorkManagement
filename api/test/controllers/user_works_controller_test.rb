require 'test_helper'

class UserWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_work = user_works(:one)
  end

  test "should get index" do
    get user_works_url, as: :json
    assert_response :success
  end

  test "should create user_work" do
    assert_difference('UserWork.count') do
      post user_works_url, params: { user_work: { user_id: @user_work.user_id, work_id: @user_work.work_id } }, as: :json
    end

    assert_response 201
  end

  test "should show user_work" do
    get user_work_url(@user_work), as: :json
    assert_response :success
  end

  test "should update user_work" do
    patch user_work_url(@user_work), params: { user_work: { user_id: @user_work.user_id, work_id: @user_work.work_id } }, as: :json
    assert_response 200
  end

  test "should destroy user_work" do
    assert_difference('UserWork.count', -1) do
      delete user_work_url(@user_work), as: :json
    end

    assert_response 204
  end
end
