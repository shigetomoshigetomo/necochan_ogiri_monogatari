class Post < ApplicationRecord
  belongs_to :member
  belongs_to :board

  has_one_attached :image

  with_options presence: true do
    validates :content
    validates :member_id
    validates :board_id
  end

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
