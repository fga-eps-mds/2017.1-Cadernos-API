json.extract! book, :id, :title, :user_id, :created_at, :updated_at, :cover_original, :cover_medium, :cover_thumb
json.user book.user, :id, :name, :email, :created_at, :updated_at
