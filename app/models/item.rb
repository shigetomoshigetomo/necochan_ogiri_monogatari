class Item < ApplicationRecord
  belongs_to :genre

  with_options presence: true do
    validates :name
    validates :price
    validates :having_exp
    validates :genre_id
  end
end
