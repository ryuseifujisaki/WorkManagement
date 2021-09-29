require 'test_helper'

class WorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work = works(:one)
  end

  test "should get index" do
    get works_url, as: :json
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post works_url, params: { work: { belonging: @work.belonging, carfare: @work.carfare, cloth: @work.cloth, content: @work.content, day: @work.day, limit: @work.limit, money: @work.money, name: @work.name, other: @work.other, where: @work.where } }, as: :json
    end

    assert_response 201
  end

  test "should show work" do
    get work_url(@work), as: :json
    assert_response :success
  end

  test "should update work" do
    patch work_url(@work), params: { work: { belonging: @work.belonging, carfare: @work.carfare, cloth: @work.cloth, content: @work.content, day: @work.day, limit: @work.limit, money: @work.money, name: @work.name, other: @work.other, where: @work.where } }, as: :json
    assert_response 200
  end

  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete work_url(@work), as: :json
    end

    assert_response 204
  end
end
