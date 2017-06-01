# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_test = User.create(name: 'teste', email: 'test@mail.com', email_confirmation: 'test@mail.com', password: '123456')
user_fulano = User.create(name: 'fulano', email: 'fulano@mail.com', email_confirmation: 'fulano@mail.com', password: '123456')

book1 = Book.create(title: 'Um retrato da periferia', user: user_test)
book2 = Book.create(title: 'Alto da compadecida', user: user_test)
book3 = Book.create(title: 'Exposição de literatura', user: user_fulano)
book4 = Book.create(title: 'Memórias de um sargento de mílicias', user: user_fulano)

Task.create(title: 'Achar música motivacional', content: 'Tem que ser de uma banda grunge', book: book1)
Task.create(title: 'Montar figurino', content: 'Chicó, Jesus, Maria e o Diabo', book: book2)
Task.create(title: 'Descobrir uma Capitu', content: 'Tem que achar uma traíra', book: book3)
Task.create(title: 'Estudar projeto de artes', content: 'Projeto XPTO e XPTA', book: book4)

Task.create(title: 'Propor filme', content: 'Um filme que retrate a periferia', book: book1)
Task.create(title: 'Montar sonoplastia', content: 'Música em modo dórico', book: book2)
Task.create(title: 'Catalogar obras', content: 'Tem que ser por periodos', book: book3)
Task.create(title: 'Estudar RIO em 1800', content: 'Vida, hábitos, roupas', book: book4)
