json.extract! image, :id, :name, :file, :description, :created_at, :updated_at
json.url image_url(image, format: :json)
