class Board < ApplicationRecord
  belongs_to :member
  has_many :posts, dependent: :destroy
  default_scope -> {order(created_at: :desc)}

  has_one_attached :image

  validates :title, presence: true
  validates :member_id, presence: true

  is_impressionable

  acts_as_taggable

end
