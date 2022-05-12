class Post < ApplicationRecord
  belongs_to :member
  belongs_to :board
  has_many :favorites, dependent: :destroy
  has_many :unlikes, dependent: :destroy

  default_scope -> {order(created_at: :desc)}
  scope :favorites_rank, -> { all.sort { |a,b| b.favorites.count <=> a.favorites.count } } #いいね多い順

  has_one_attached :image

  with_options presence: true do
    validates :content
    validates :member_id
    validates :board_id
  end

  validates :content, length: { maximum: 100 }

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def unliked_by?(member)
    unlikes.exists?(member_id: member.id)
  end
end
