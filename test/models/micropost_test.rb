require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
 
 def setup
   @user = users(:tommy)
   @micropost = @user.microposts.build(content: 'Lorem ipsum')
               #Micropost.new(content:'Lorem ipsum', user_id: @user.id)
 end

 test 'Should be valid' do
   assert @micropost.valid?
 end

 test 'User id should be present' do
   @micropost.user_id = nil
   assert_not @micropost.valid?
   # assert @micropost.user_id.present?
   # assert_not @micropost.user_id.blank?
   # assert_not_nil @micropost.user_id
   # assert_not @micropost.user_id.nil?
 end

 test 'content should be present' do
   @micropost.content = "   "
   assert_not @micropost.valid?
 end

 test 'should have max length 140 char' do
   @micropost.content = 'a'* 141
   assert_not @micropost.valid?
 end
 
 test 'should order by most recent' do
   assert_equal microposts(:four), Micropost.first
 end


end
