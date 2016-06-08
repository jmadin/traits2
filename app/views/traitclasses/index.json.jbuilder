json.array!(@traitclasses) do |traitclass|
  json.extract! traitclass, :id, :user_id, :class_name, :class_description, :contextual
  json.url traitclass_url(traitclass, format: :json)
end
