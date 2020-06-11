require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:tommy)
  end
#the main purpose is to be sure that clicking the submit button
#is not creating new user
test "login with valid email/invalid password" do
  get login_path
  assert_template 'sessions/new'
  post login_path, params: { session: { email:    @user.email,
                                        password: "invalid" } }
  assert_not is_logged_in?
  assert_template 'sessions/new'
  assert_not flash.empty?
  get root_path
  assert flash.empty?
end


  #test to see if all the links are changing when user logs in
test 'link changes on log in and log out' do
  get login_path
  post login_path, params: { session:
                           { email: @user.email,
                             password: 'password'}}
  assert is_logged_in?
  assert_redirected_to @user
  follow_redirect!
  assert_template 'users/show'
  assert_select 'a[href=?]', login_path, count:0
  assert_select 'a[href=?]', logout_path, count:1
  assert_select 'a[href=?]', user_path(@user)
  delete logout_path
  assert_not is_logged_in?
  assert_redirected_to root_url
  follow_redirect!
  assert_select "a[href=?]", login_path
  assert_select "a[href=?]", logout_path,      count: 0
  assert_select "a[href=?]", user_path(@user), count: 0
 end
end