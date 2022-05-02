class Post < ApplicationRecord
  belongs_to :member
  belongs_to :board

  with_options presence: true do
    validates :content
    validates :member_id
    validates :board_id
  end
end
