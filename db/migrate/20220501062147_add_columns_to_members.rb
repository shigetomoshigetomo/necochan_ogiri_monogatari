class AddColumnsToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :name, :string
    add_column :members, :exp, :integer, default: 0
    add_column :members, :money, :integer, default:0
    add_column :members, :level, :integer, default:1
    add_column :members, :is_deleted, :boolean, default: false
    add_index :members, :name, unique: true
  end
end
