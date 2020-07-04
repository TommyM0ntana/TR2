require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:tommy)
  end

  test 'microposts interface' do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_no_difference 'Micropost.count'  do
      post microposts_path params: { micropost: { content: '' }}
    end
    assert_select 'div#error_explanation'
    assert_difference 'Micropost.count', 1 do
      post microposts_path params: { micropost: { content: 'Lorem' }}
    end
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_match 'Lorem', response.body
    second_post = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(second_post)
    end
    get user_path(@user)
    assert_select 'a', { text: 'Delete', count: 30 }
    get user_path(users(:sammy))
    assert_select 'a', { text: 'Delete', count: 0 }
    

   

  end

 
end
