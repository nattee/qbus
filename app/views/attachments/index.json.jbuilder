json.set! :data do
  json.array! @attachments do |attachment|
    json.partial! 'attachments/attachment', attachment: attachment
    json.url  "
              #{link_to 'Show', attachment }
              #{link_to 'Edit', edit_attachment_path(attachment)}
              #{link_to 'Destroy', attachment, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end