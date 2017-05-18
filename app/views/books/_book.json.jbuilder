json.extract! book, :id, :title, :created_at, :updated_at, :cover
json.url book_url(book, format: :json)
