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
              threshold: 1
              )

100.times do |n|
  n = 2
  before_level = Level.find(n-1)
  current_level = n + 1
  a = before_level.threshold * 1.1
  b = current_level * 15
  Level.create!(level: n + 1,
                threshold: (a + b) / 2
                )
end