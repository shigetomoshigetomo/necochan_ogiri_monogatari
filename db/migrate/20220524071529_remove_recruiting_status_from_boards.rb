class RemoveRecruitingStatusFromBoards < ActiveRecord::Migration[6.1]
  def change
    remove_column :boards, :recruiting_status, :boolean
  end
end
