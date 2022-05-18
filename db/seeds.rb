# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: ENV['ADMIN_EMAIL'],
              password: ENV['ADMIN_PASSWORD']
              )

Level.create!(level: 1,
              threshold: 10
              )

level = 1
for i in 1..199
  new_level = level + i
  before_level = Level.find(new_level - 1)  #一つ前のレベルを探す
  new_threshold = before_level.threshold * 1.1  #一つ前のレベルの闘値に1.1掛ける
  Level.create!(level: new_level,
                threshold: new_threshold
                )
end

Genre.create!([{name: "武器屋"}, {name: "道具屋"}, {name: "食堂"}])

# Item.create!(
#   [
#     {name: 'Cavello', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), caption: '大人気のカフェです。', user_id: users[0].id },
#     {shop_name: '和食屋せん', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), caption: '日本料理は美しい！', user_id: users[1].id },
#     {shop_name: 'ShoreditchBar', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), caption: 'メキシコ料理好きな方にオススメ！', user_id: users[2].id }
#   ]
# )




# t.string "name", null: false
#     t.integer "having_exp", null: false
#     t.integer "price", null: false
#     t.integer "genre_id", null: false
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.text "introduction"