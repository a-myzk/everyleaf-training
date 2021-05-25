# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "taro"
email = "taro@a.com"
password = "0000pppp"
User.create!(name: name, email: email, password: password, password_confirmation: password, admin: true)

5.times do |n|
  Label.create!(
    label_name: "ラベル#{n + 1}",
  )
end
