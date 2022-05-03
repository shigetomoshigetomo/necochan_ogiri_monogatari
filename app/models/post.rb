class Post < ApplicationRecord
  belongs_to :member
  belongs_to :board
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  with_options presence: true do
    validates :content
    validates :member_id
    validates :board_id
  end

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
