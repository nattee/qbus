json.set! :data do
  json.array! @criteria do |criterium|
    json.partial! 'criteria/criterium', criterium: criterium
    json.url  "
              #{link_to 'Show', criterium }
              #{link_to 'Edit', edit_criterium_path(criterium)}
              #{link_to 'Destroy', criterium, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end