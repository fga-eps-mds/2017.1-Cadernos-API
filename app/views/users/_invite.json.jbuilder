json.extract! invite, :id, :sender_id, :recipient_id, :recipient_name, :book_id, :book_title, :sender_name, :created_at, :updated_at
json.url invite_url(invite, format: :json)
