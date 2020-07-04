require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  
 def setup
  @user = users(:tommy) 
 end

test 'check all the users page utilities' do
  get user_path(@user)
  assert_template 'users/show'
  assert_select 'div>img.gravatar'
  assert_select 'a', text: @user.name, count:30
  assert_select 'div.pagination'
  assert_match @user.microposts.count.to_s, response.body
  @user.microposts.paginate(page: 1).each do |micropost|
    assert_match micropost.content, response.body 
  end
end

end
