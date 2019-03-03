json.set! :data do
  json.array! @datafiles do |datafile|
    json.partial! 'datafiles/datafile', datafile: datafile
    json.url  "
              #{link_to 'Show', datafile }
              #{link_to 'Edit', edit_datafile_path(datafile)}
              #{link_to 'Destroy', datafile, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end