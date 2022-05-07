class ChangeDataThresholdToLevel < ActiveRecord::Migration[6.1]
  def change
    change_column :levels, :threshold, :float
  end
end
