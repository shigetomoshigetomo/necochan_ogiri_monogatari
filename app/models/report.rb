class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Member"
  belongs_to :reported, class_name: "Member"
  has_many :report_comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  with_options presence: true do
    validates :reporter_id
    validates :reported_id
    validates :reason
    validates :status
  end

  validates :reason, length: { maximum: 200 }
  validates :url, length: { maximum: 100 }

  enum status: { waiting: 0, keep: 1, finish: 2 } # 対応ステータス
end
