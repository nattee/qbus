json.set! :data do
  json.array! @cars do |car|
    json.partial! 'cars/car', car: car
    json.url  "
              #{link_to 'Show', car }
              #{link_to 'Edit', edit_car_path(car)}
              #{link_to 'Destroy', car, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end