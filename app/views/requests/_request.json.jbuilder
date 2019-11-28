json.extract! request, :id, :amount, :created_at, :updated_at
json.url request_url(request, format: :json)
