json.extract! admin, :id, :username, :password, :status, :created_at, :updated_at
json.url admin_url(admin, format: :json)