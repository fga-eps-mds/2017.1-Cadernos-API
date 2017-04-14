# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(name: 'lucas', email: 'emailTest@email.com', email_confirmation: 'emailTest@email.com', password: '123456')
User.create(name: 'teste', email: 'emailTest1@email.com', email_confirmation: 'emailTest1@email.com', password: '1234567')

Book.create(title: 'testLivro', user_id: 1)
Book.create(title: 'testLivro2', user_id: 1)
Book.create(title: 'testLivro3', user_id: 2)
Task.create(title: 'taskTitle', content: 'testContent', book_id: 1)
Task.create(title: 'taskTitle', content: 'testContent', book_id: 1)
