class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :items, through: :orders
  has_many :orders, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

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

  #ゲストユーザー作成
  def self.guest
    find_or_create_by!(name: 'ゲスト' ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "ゲスト"
    end
  end

  #フォロー・フォロワー機能
  def follow(member_id)
    relationships.create(followed_id:member_id)
  end

  def unfollow(member_id)
    relationships.find_by(followed_id:member_id).destroy
  end

  def following?(member)
    followings.include?(member)
  end
end
