require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:tommy)
  end

  test 'microposts interface' do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # assert_select 'input[type=FILL_IN]'
    assert_no_difference 'Micropost.count'  do
      post microposts_path params: { micropost: { content: '' }}
    end
    assert_select 'div#error_explanation'
    image = fixture_file_upload('test/fixtures/beach1.jpg', 'image/jpeg')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: 'Lorem',
                                                  image: image }}
    end
    assert assigns(:micropost).image.attached?
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
