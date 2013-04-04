require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:andrew).profile_name
  	assert !user.save
  	puts user.errors.inspect
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Andrew', last_name: 'Chellinsky', email: 'chellinsky@gmail.com')
    user.password = user.password_confirmation = 'asdfasdf'
  	user.profile_name = "My Profile Name With Spaces"

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Andrew', last_name: 'Chellinsky', email: 'chellinsky@gmail.com')
    user.password = user.password_confirmation = 'asdfasdf'
    user.profile_name = 'chellinsky_1'
    assert user.valid?
  end

  test "that no error is raised when trying to get to a friend" do
    assert_nothing_raised do
      users(:andrew).friends
    end
  end

  test "that user can create friendships" do
    users(:andrew).friends << users(:mtf)
    users(:andrew).friends.reload
    assert users(:andrew).friends.include?(users(:mtf))
  end
end
