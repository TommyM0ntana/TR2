class Micropost < ApplicationRecord
  belongs_to :user
  #order('created_at DESC')
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  has_one_attached :image
  validates :image, content_type: { in: %w[image/png image/gif image/jpeg],
                                    message: 'file is invalid format'},
                    size:         { less_than: 5.megabytes,
                                    message: 'is too big,should be less than 5 MB' }
  
  def display_image
    image.variant(resize_to_limit: [500, 500] )
  end
                                           

end
