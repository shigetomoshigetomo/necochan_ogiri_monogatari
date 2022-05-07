class ChangeDataThresholdToLevel < ActiveRecord::Migration[6.1]
  def change
    change_column :levels, :threshold, :integer
  end
end
