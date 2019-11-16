json.extract! request, :id, :amount, :date, :created_at, :updated_at
json.url request_url(request, format: :json)
