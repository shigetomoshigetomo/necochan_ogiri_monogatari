class ReportComment < ApplicationRecord
  belongs_to :report

  default_scope -> { order(created_at: :desc) }

  validates :comment, presence: true
end
