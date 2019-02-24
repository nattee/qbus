json.set! :data do
  json.array! @applications do |application|
    json.partial! 'applications/application', application: application
    json.url  "
              #{link_to 'Show', application }
              #{link_to 'Edit', edit_application_path(application)}
              #{link_to 'Destroy', application, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end