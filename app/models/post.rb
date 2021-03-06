class Post < ApplicationRecord
  belongs_to :member
  belongs_to :board
  has_many :favorites, dependent: :destroy
  has_many :unlikes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  scope :favorites_rank, -> { all.sort { |a, b| b.favorites.count <=> a.favorites.count } } # いいね多い順

  has_one_attached :image

  validates :content, length: { maximum: 100 }, presence: true

  paginates_per 6

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def unliked_by?(member)
    unlikes.exists?(member_id: member.id)
  end

  def create_notification_like!(current_member)
    # すでに「いいね」されているか検索
    existing_notification = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_member.id, member_id, id, 'like'])
    # いいねされていない場合のみ、通知を作成
    if existing_notification.blank?
      notification = current_member.active_notifications.new(
        post_id: id,
        visited_id: member_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def get_exp()
    rand(1..5)
  end

  def get_money()
    rand(3..6)
  end
end
