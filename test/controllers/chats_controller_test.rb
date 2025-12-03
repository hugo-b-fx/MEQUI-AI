require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chats_index_url
    assert_response :success
  end

  test "should get show" do
    get chats_show_url
    assert_response :success
  end

  test "should get create_message" do
    get chats_create_message_url
    assert_response :success
  end
end
