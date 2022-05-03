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
for i in 1..299
  new_level = level + i
  before_level = Level.find(new_level - 1)  #一つ前のレベルを探す
  new_threshold = before_level.threshold * 1.1  #一つ前のレベルの闘値に1.1掛ける
  Level.create!(level: new_level,
                threshold: new_threshold
                )
end