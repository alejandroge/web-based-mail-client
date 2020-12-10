json.extract! email, :id, :subject, :to, :body, :user_id, :created_at, :updated_at
json.url email_url(email, format: :json)
