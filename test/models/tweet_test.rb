require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  
  test "screen name should not have white spaces" do
    assert_no_match /\S\s\S/, tweets(:one).user_screen_name, "Screen name with a space was accept."
  end
  # test "the truth" do
  #   assert true
  # end
end
