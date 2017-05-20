json.extract! book, :id, :title, :user_id, :created_at, :updated_at, :cover
json.url book_url(book, format: :json)
