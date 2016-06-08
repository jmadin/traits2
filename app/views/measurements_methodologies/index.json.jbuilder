json.array!(@measurements_methodologies) do |measurements_methodology|
  json.extract! measurements_methodology, :id, :measurement_id, :methodology_id
  json.url measurements_methodology_url(measurements_methodology, format: :json)
end
