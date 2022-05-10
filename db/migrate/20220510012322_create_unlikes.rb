class CreateUnlikes < ActiveRecord::Migration[6.1]
  def change
    create_table :unlikes do |t|
      t.integer :member_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
