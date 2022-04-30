class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :having_exp, null: false
      t.integer :price, null: false
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
