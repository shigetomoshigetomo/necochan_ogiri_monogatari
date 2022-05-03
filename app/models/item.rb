class Item < ApplicationRecord
  belongs_to :genre
  has_many :members, through: :orders
  has_many :orders, dependent: :destroy

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :price
    validates :having_exp
    validates :introduction
    validates :genre_id
  end
end
