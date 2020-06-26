require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest


 def setup
  ActionMailer::Base.deliveries.clear
 end

  test 'unvalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
                       name: '',
                       email: 'example@gmail',
                       password: 'foo',
                       password_confirmation: 'bar' }}
    end
   assert_template  'users/new'
 end

 test "valid signup information with account activation" do
  get signup_path
  assert_difference 'User.count', 1 do
    post users_path, params: { user: { name:  "Example User",
                                       email: "user@example.com",
                                       password:              "password",
                                       password_confirmation: "password" } }
  end
  assert_equal 1, ActionMailer::Base.deliveries.size
  user = assigns(:user)
  assert_not user.activated?
  #Try to log in before activation
  log_in_as(user)
  assert_not is_logged_in?
  #invalid activation token , right email
  get edit_account_activation_path("Invalid token", email: user.email)
  assert_not is_logged_in?
  #right token,wrong email
  get edit_account_activation_path(user.activation_token, email:'wrong')
  assert_not is_logged_in?
  #valid activation token
  get edit_account_activation_path(user.activation_token, email: user.email)
  assert user.reload.activated?
  follow_redirect!
  # skip
  # assert_template 'users/show'
  # assert is_logged_in?
end

end
