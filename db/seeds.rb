Location.create!([
  {user_id: 1, location_name: "Global Estimate", latitude: "0.0", longitude: "0.0", location_description: nil, approved: nil},
  {user_id: 1, location_name: "South Island reef, Lizard Island, Great Barrier Reef", latitude: "-14.70406", longitude: "145.459409", location_description: "", approved: false}
])
Measurement.create!([
  {user_id: nil, observation_id: 1, trait_id: 3, standard_id: 4, methodology_id: nil, value: "8", valuetype_id: 1, precision: "", precisiontype_id: nil, precision_upper: "", replicates: "", measurement_description: ""},
  {user_id: nil, observation_id: 1, trait_id: 1, standard_id: 16, methodology_id: nil, value: "12.2", valuetype_id: 2, precision: "10.3", precisiontype_id: 3, precision_upper: "13.4", replicates: "20", measurement_description: ""},
  {user_id: nil, observation_id: 1, trait_id: 2, standard_id: 1, methodology_id: nil, value: "Tabular", valuetype_id: 1, precision: "", precisiontype_id: nil, precision_upper: "", replicates: "", measurement_description: ""}
])
MeasurementsMethodology.create!([
  {measurement_id: 1, methodology_id: 1},
  {measurement_id: 2, methodology_id: 2}
])
Methodology.create!([
  {user_id: 1, methodology_name: "Depth gage", methodology_description: "", approved: false},
  {user_id: 1, methodology_name: "X-radiography", methodology_description: "", approved: false}
])
Observation.create!([
  {user_id: 1, specie_id: 1, location_id: 2, resource_id: 1, resource_secondary_id: nil, access: true, approved: true}
])
Precisiontype.create!([
  {user_id: 1, precision_type_name: "Standard deviation", precision_type_description: "", has_range: false},
  {user_id: 1, precision_type_name: "Standard error", precision_type_description: "", has_range: false},
  {user_id: 1, precision_type_name: "Range", precision_type_description: "", has_range: true}
])
Resource.create!([
  {user_id: 1, author: "Madin, J. S., Kuo, C., Martinelli, J. C., Mizerek, T., Baird, A. H.", year: 2014, title: "Very high coral cover at 36°S on the east coast of Australia", resource_type: "", doi_isbn: "10.1007/s00338-014-1248-9", journal: "Coral Reefs", volume_pages: "34, 327-327", resource_description: "", approved: false}
])
Specie.create!([
  {user_id: 1, specie_name: "Acropora gemmifera", specie_description: "", aphia_id: "", approved: false},
  {user_id: 1, specie_name: "Acropora hyacinthus", specie_description: "", aphia_id: "", approved: false},
  {user_id: 1, specie_name: "Goniastrea retiformis", specie_description: "", aphia_id: "", approved: false}
])
Standard.create!([
  {user_id: 1, standard_name: "Category", standard_unit: "cat", standard_class: "Nominal class", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Count", standard_unit: "units", standard_class: "Base unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Degrees", standard_unit: "deg", standard_class: "Base unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Degrees Celsius", standard_unit: "ºC", standard_class: "Base unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Density", standard_unit: "m2/m2", standard_class: "Index", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Density", standard_unit: "kg/m2", standard_class: "Complex derived unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Density", standard_unit: "kg/m3", standard_class: "Complex derived unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Density", standard_unit: "kg/kg", standard_class: "Index", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Extension rate", standard_unit: "mm yr^-1", standard_class: "Complex derived unit", standard_description: "", approved: false},
  {user_id: 1, standard_name: "Kilogram", standard_unit: "kg", standard_class: "Base unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Meter", standard_unit: "m", standard_class: "Base unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Meter square", standard_unit: "m2", standard_class: "Simple derived unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Millimeter", standard_unit: "mm", standard_class: "Base unit", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Name", standard_unit: "text", standard_class: "Nominal class", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Text", standard_unit: "text", standard_class: "Nominal class", standard_description: nil, approved: nil},
  {user_id: 1, standard_name: "Year", standard_unit: "yr", standard_class: "Datetime", standard_description: nil, approved: nil}
])
Trait.create!([
  {user_id: 1, trait_name: "Growth rate", trait_description: "", traitclass_id: 3, standard_id: 16, log_data: true, approved: false, released: false, hide: false},
  {user_id: 1, trait_name: "Growth form", trait_description: "The morphology of the organism.", traitclass_id: 3, standard_id: 1, log_data: false, approved: false, released: false, hide: false},
  {user_id: 1, trait_name: "Depth", trait_description: "The depth at which the organism was observed.", traitclass_id: 1, standard_id: 4, log_data: false, approved: false, released: false, hide: false}
])
Traitclass.create!([
  {user_id: 1, class_name: "Contextual", class_description: nil, contextual: true},
  {user_id: 1, class_name: "Ecological", class_description: nil, contextual: nil},
  {user_id: 1, class_name: "Organismal", class_description: nil, contextual: nil}
])
Traitvalue.create!([
  {value_name: "Digitate", trait_id: 2, value_description: ""},
  {value_name: "Tabular", trait_id: 2, value_description: ""},
  {value_name: "Massive", trait_id: 2, value_description: ""}
])

User.create!(first_name: "Dr", last_name: "Admin", email: "admin@traits.org", password: "foobar", password_confirmation: "foobar", contributor: true, editor: true, admin: true, activated: true, activated_at: Time.zone.now)

Valuetype.create!([
  {user_id: 1, value_type_name: "Raw value", value_type_description: "Value as measured by observer.", has_precision: false},
  {user_id: 1, value_type_name: "Mean", value_type_description: "The mean of multiple raw values.", has_precision: true}
])
