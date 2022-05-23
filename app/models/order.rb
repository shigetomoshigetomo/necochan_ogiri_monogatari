class Order < ApplicationRecord
  belongs_to :member
  belongs_to :item

  default_scope -> { order(created_at: :desc) }

  with_options presence: true do
    validates :member_id
    validates :item_id
  end
end
