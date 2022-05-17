class Board < ApplicationRecord
  belongs_to :member
  has_many :posts, dependent: :destroy

  default_scope -> {order(created_at: :desc)}
  scope :posts_rank, -> { all.sort { |a,b| b.posts.count <=> a.posts.count } } #投稿多い順
  scope :views_rank, -> { all.sort { |a,b| b.impressionist_count(:filter=>:session_hash) <=>
                                           a.impressionist_count(:filter=>:session_hash) } } #閲覧多い順

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :member_id, presence: true

  is_impressionable

  acts_as_taggable
end