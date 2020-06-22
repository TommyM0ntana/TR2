require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

 def setup
   @user = users(:tommy)
  #  @other_user = users(:jimmy)
 end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: {user: { name: '',
                                             email: 'foo@',
                                             password: 'bar',
                                             password_confirmation: 'foo'                               
    }}
    assert_template 'users/edit'
    assert_select "div.alert", text: "The form contains 4 errors."                                           
  end

 test 'successful edit with friendly forwarding' do
   get edit_user_path(@user)
   assert session[:forwarding_url]
   log_in_as(@user)
   assert_redirected_to edit_user_url(@user)
   name  = 'johnny'
   email = 'johnny@gmail.com'
   patch user_path(@user), params: { user: { name: name, 
                                              email: email,
                                              password:'',
                                              password_confirmation:'' }}
   assert_not flash.empty?
   assert_redirected_to @user
   assert_nil session[:forwarding_url]
   @user.reload
   assert_equal name, @user.name
   assert_equal email, @user.email
  end


end
