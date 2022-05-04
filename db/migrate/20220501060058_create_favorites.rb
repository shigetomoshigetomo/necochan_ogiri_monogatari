class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :member, null: false, foreign_key: true
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
