User.create!(name: "admin",
  email: "admin@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  is_admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "test#{n+1}@gmail.com"
  password = "123123"
  User.create!(name: name, email: email,password: password,
    password_confirmation: password)
end

5.times do |n|
  name = Faker::Name.name
  Category.create!(
    category_name: name
  )
end

categories = Category.take(3)
30.times do
  title = Faker::Book.title
  author = Faker::Book.author
  description = Faker::Lorem.characters(100)
  date = Faker::Date.between(2.days.ago, Date.today)
  number_page = Faker::Number.between(1, 100)
  categories.each{ |cat|
    cat.books.create!(title: title,author: author,
      publish_date: date, number_of_page: number_page,description: description)
  }
end

categories = Category.find 4
3.times do
  title = Faker::Book.title
  author = Faker::Book.author
  description = Faker::Lorem.characters(100)
  date = Faker::Date.between(2.days.ago, Date.today)
  number_page = Faker::Number.between(1, 100)
  categories.books.create!(title: title,author: author,
    publish_date: date, number_of_page: number_page,description: description)
end
