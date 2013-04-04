require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should belong_to(:user)
  should belong_to(:friend)
 
  test "that creating a friendship works without raising an exception" do
  	assert_nothing_raised do
  		UserFriendship.create user: users(:andrew), friend: users(:mtf)
  	end
  end

  test "that creating a friendship based on user id and friend id works" do
  	UserFriendship.create user_id: users(:andrew).id, friend_id: users(:mtf)
  	assert users(:andrew).friends.include?(users(:mtf))
  end

end
