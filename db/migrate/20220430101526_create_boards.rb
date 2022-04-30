class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.text :title, null: false
      t.references :member, null: false, foreign_key: true
      t.boolean :recruiting_status, null: false, default: true

      t.timestamps
    end
  end
end
