class ChangeColumnDefaultToMembers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :members, :exp, from: 0, to: 10
  end
end
