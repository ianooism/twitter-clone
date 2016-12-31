require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test 'should follow and unfollow a user' do
    a = users(:a)
    b = users(:b)
    assert_not a.following?(b)
    a.follow(b)
    assert a.following?(b)
    assert b.followers.include?(a)
    a.unfollow(b)
    assert_not a.following?(b)
    assert_not b.followers.include?(a)
  end
end
