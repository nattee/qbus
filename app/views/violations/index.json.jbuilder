json.set! :data do
  json.array! @violations do |violation|
    json.partial! 'violations/violation', violation: violation
    json.url  "
              #{link_to 'Show', violation }
              #{link_to 'Edit', edit_violation_path(violation)}
              #{link_to 'Destroy', violation, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end