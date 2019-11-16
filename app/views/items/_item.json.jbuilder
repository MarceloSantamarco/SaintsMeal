json.extract! item, :id, :name, :kind, :description, :price, :created_at, :updated_at
json.url item_url(item, format: :json)
