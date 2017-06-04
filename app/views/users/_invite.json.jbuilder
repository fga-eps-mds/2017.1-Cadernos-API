json.extract! invite, :id, :sender_id, :recipient_id, :book_id,:created_at, :updated_at
json.url invite_url(invite, format: :json)
