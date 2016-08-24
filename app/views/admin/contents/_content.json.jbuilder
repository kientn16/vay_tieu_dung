json.extract! content, :id, :title, :description, :content, :status, :type, :created_at, :updated_at
json.url content_url(content, format: :json)