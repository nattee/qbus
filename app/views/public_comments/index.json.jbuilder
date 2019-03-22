json.set! :data do
  json.array! @public_comments do |public_comment|
    json.partial! 'public_comments/public_comment', public_comment: public_comment
    json.url  "
              #{link_to 'Show', public_comment }
              #{link_to 'Edit', edit_public_comment_path(public_comment)}
              #{link_to 'Destroy', public_comment, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end