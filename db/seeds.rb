# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.create(name: 'teste', email: 'test@mail.com', email_confirmation: 'test@mail.com', password: '123456')
@book = Book.create(title: 'testLivro', user: @user)
Task.create(title: 'taskTitle', content: 'testContent', book: @book, user_id: @user.id)
