json.array!(@valuetypes) do |valuetype|
  json.extract! valuetype, :id, :user_id, :value_type_name, :value_type_description, :has_precision
  json.url valuetype_url(valuetype, format: :json)
end
