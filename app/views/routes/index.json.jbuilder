json.set! :data do
  json.array! @routes do |route|
    json.partial! 'routes/route', route: route
    json.url  "
              #{link_to 'Show', route }
              #{link_to 'Edit', edit_route_path(route)}
              #{link_to 'Destroy', route, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end