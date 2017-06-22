json.extract! task, :id, :title, :content, :book_id, :user_id, :category_id, :created_at, :updated_at, :picture_original, :picture_medium, :picture_thumb
json.user do
    json.id task.user.id
    json.name task.user.name
end
