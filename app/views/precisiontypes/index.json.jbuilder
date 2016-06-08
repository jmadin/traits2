json.array!(@precisiontypes) do |precisiontype|
  json.extract! precisiontype, :id, :user_id, :precision_type_name, :precision_type_description, :has_range
  json.url precisiontype_url(precisiontype, format: :json)
end
