class AddIntroductionToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :introduction, :text
  end
end
