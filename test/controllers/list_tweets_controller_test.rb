require 'test_helper'

class ListTweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get list_tweets_index_url
    assert_response :success
  end

end
