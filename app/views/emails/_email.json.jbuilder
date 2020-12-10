json.extract! email, :id, :subject, :to, :body, :created_at, :updated_at
json.url email_url(email, format: :json)
