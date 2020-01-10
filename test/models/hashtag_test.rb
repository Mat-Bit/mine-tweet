require 'test_helper'

class HashtagTest < ActiveSupport::TestCase

  test "tag should not have white spaces" do
    assert_no_match /\S\s\S/, hashtags(:one).tag, "tag with a space was accept."
  end

end
