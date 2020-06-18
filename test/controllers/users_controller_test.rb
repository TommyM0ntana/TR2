require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

    def setup
      @user = users(:tommy)
      @other_user = users(:jimmy)
    end

    test "should get new" do
      get signup_path
      assert_response :success
    end

    test 'should get index when not logged in' do
      get users_path
      assert_redirected_to login_url
    end

    test 'should redirect to edit when the user is wrong ' do
      get edit_user_path(@user)
      assert_not flash.empty?
      assert_redirected_to login_path
  end

  test 'should redirect to update when the user is wrong' do
   patch user_path(@user), params: { user: { name: @user.name,
                                           email: @user.email }}
   assert_not flash.empty?
   assert_redirected_to login_url
 end
 
end
