5.times do |n|
  name = Faker::Name.name
  Category.create!(
    category_name: name
  )
end

categories = Category.take(5)
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
