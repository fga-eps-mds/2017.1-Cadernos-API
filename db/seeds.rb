# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.create(name: 'teste', email: 'test@mail.com', email_confirmation: 'test@mail.com', password: '123456')
@book1 = Book.create(title: 'test caderno 1', user: @user)
@book2 = Book.create(title: 'test caderno 2', user: @user)
@categories = Category.first(3)


i = 0
@categories.each do |c|
  Task.create! title: "task title #{i}", content: 'test content', book: @book1, user: @user, category: c
  i += 1
  
  Task.create! title: "task title #{i}", content: 'test content', book: @book1, user: @user, category: c
  i += 1
end


@categories.each do |c|
  Task.create! title: "task title #{i}", content: 'test content', book: @book2, user: @user, category: c
  i += 1
  
  Task.create! title: "task title #{i}", content: 'test content', book: @book2, user: @user, category: c
  i += 1
end
