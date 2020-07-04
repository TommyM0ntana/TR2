require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:one)
    @user = users(:tommy)
  end

 test 'if create and not logged in redirect' do
   assert_no_difference 'Micropost.count' do
     post microposts_path, params: { micropost: { content: 'Lorem ipsum'} }
   end
   assert_redirected_to login_url
 end
 
 test 'if delete and not logged in redirect' do
   assert_no_difference 'Micropost.count' do
     delete micropost_path(@micropost)
   end
   assert_redirected_to login_url
 end

test 'should redirect destroy if wrong user' do
  log_in_as(@user)
  micropost = microposts(:five)
  assert_no_difference 'Micropost.count' do
    delete micropost_path(micropost)  
  end
  assert_redirected_to root_url
  
end


end
