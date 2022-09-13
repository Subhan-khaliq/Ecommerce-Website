json.extract! product, :id, :serial_number, :name, :price, :user_id, :created_at, :updated_at
json.url product_url(product, format: :json)
