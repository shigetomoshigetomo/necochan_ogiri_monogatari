class CreateReportComments < ActiveRecord::Migration[6.1]
  def change
    create_table :report_comments do |t|
      t.integer :report_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
