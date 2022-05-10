class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Member"
  belongs_to :reported, class_name: "Member"

  with_options presence: true do
    validates :reporter_id
    validates :reported_id
    validates :reason
    validates :status
  end

  enum status: { waiting: 0, keep: 1, finish: 2 } #対応ステータス
end
