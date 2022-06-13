class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :boards, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :unlikes, dependent: :destroy
  has_many :items, through: :orders
  has_many :orders, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  scope :not_guest, -> { where.not(email: "guest@example.com") } # ゲスト以外の会員
  scope :all_favorites, -> {
                          sort do |a, b|
                            b.posts.inject(0) { |sum, post| sum + post.favorites.count } <=>
                            a.posts.inject(0) { |sum, post| sum + post.favorites.count }
                          end
                        } # 全いいね多い順
  scope :follower_rank, -> { sort { |a, b| b.followers.count <=> a.followers.count } } # フォロワー多い順

  with_options presence: true do
    validates :name
    validates :email
    validates :exp
    validates :money
    validates :level
  end

  with_options uniqueness: true do
    validates :name
    validates :email
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :name, length: { maximum: 8 }
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  paginates_per 10

  # ゲストユーザー作成
  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "ゲスト"
    end
  end

  # フォロー・フォロワー機能
  def follow(member_id)
    relationships.create(followed_id: member_id)
  end

  def unfollow(member_id)
    relationships.find_by(followed_id: member_id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  def active_for_authentication?
    # is_deletedがfalseならtrueを返すようにする
    super && (is_deleted == false)
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/nyan.png')
      profile_image.attach(io: File.open(file_path), filename: 'nyan.png', content_type: 'image/png')
    end
    profile_image
  end

  # フォロー通知作成
  def create_notification_follow!(current_member)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_member.id, id, 'follow'])
    if temp.blank?
      notification = current_member.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def add_money(money)
    update(:money => self.money + money)
  end
end
