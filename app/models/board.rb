class Board < ApplicationRecord
  belongs_to :member
  has_many :posts, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
  validates :member_id, presence: true

end
