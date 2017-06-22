json.extract! book, :id, :title, :user_id, :created_at, :updated_at, :cover_original, :cover_medium, :cover_thumb
json.url book_url(book, format: :json)
json.user book.user
