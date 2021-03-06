User.create!(
  name: "taro",
  email: "taro00000@a.com",
  password: "0000pppp",
  password_confirmation: "0000pppp",
  admin: true
)

9.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "0000pppp"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              admin: false
              )
end

10.times do |n|
  user_id = n + 1
  Task.create!(
    title: "task#{n + 1}",
    content: "content#{n + 1}",
    expired_at: "2021-01-01 00:00:00",
    status: 1,
    priority: 1,
    user_id: user_id
  )
end

10.times do |n|
  Label.create!(
    label_name: "ラベル#{n + 1}"
  )
end
