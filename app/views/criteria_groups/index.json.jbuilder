json.set! :data do
  json.array! @criteria_groups do |criteria_group|
    json.partial! 'criteria_groups/criteria_group', criteria_group: criteria_group
    json.url  "
              #{link_to 'Show', criteria_group }
              #{link_to 'Edit', edit_criteria_group_path(criteria_group)}
              #{link_to 'Destroy', criteria_group, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end