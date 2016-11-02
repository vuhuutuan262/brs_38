User.create!(name: "Admin Book Review",
  email: "admin@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  is_admin: true)
99.times do |n|
  name  = Faker::Name.name
  email = "test#{n+1}@gmail.com"
  password = "123123"
  User.create!(name: name, email: email,password: password,
    password_confirmation: password, is_admin: false)
end
