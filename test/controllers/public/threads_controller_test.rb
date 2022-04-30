require "test_helper"

class Public::ThreadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_threads_index_url
    assert_response :success
  end

  test "should get new" do
    get public_threads_new_url
    assert_response :success
  end

  test "should get show" do
    get public_threads_show_url
    assert_response :success
  end
end
