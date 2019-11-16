require 'test_helper'

class WaitersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @waiter = waiters(:one)
  end

  test "should get index" do
    get waiters_url
    assert_response :success
  end

  test "should get new" do
    get new_waiter_url
    assert_response :success
  end

  test "should create waiter" do
    assert_difference('Waiter.count') do
      post waiters_url, params: { waiter: { name: @waiter.name } }
    end

    assert_redirected_to waiter_url(Waiter.last)
  end

  test "should show waiter" do
    get waiter_url(@waiter)
    assert_response :success
  end

  test "should get edit" do
    get edit_waiter_url(@waiter)
    assert_response :success
  end

  test "should update waiter" do
    patch waiter_url(@waiter), params: { waiter: { name: @waiter.name } }
    assert_redirected_to waiter_url(@waiter)
  end

  test "should destroy waiter" do
    assert_difference('Waiter.count', -1) do
      delete waiter_url(@waiter)
    end

    assert_redirected_to waiters_url
  end
end
