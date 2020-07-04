class Micropost < ApplicationRecord
  belongs_to :user
  #order('created_at DESC')
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
