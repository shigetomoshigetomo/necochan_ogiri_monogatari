class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post, optional: true

  belongs_to :visitor, class_name: 'Member', optional: true
  belongs_to :visited, class_name: 'Member', optional: true

  paginates_per 10
end
