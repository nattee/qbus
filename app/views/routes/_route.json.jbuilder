json.extract! route, :id, :name, :start, :destination, :car_count, :type, :created_at, :updated_at
json.url route_url(route, format: :json)