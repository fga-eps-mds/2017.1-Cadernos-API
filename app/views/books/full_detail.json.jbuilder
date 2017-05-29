json.book do
    json.partial! "books/book", book: @book
end

json.tasks do
    json.array! @tasks, partial: 'tasks/task', as: :task
end

json.categories do
    json.array! @categories, partial: 'categories/category', as: :category
end