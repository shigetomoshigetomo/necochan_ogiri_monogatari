class Order < ApplicationRecord
  belongs_to :member
  belongs_to :item

  with_options presence: true do
    validates :member_id
    validates :item_id
  end
end