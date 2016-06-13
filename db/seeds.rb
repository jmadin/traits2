
puts "********Seeding Data Start************"

users = User.create!(first_name: "Dr", last_name: "Admin", email: "admin@traits.org", password: "foobar", password_confirmation: "foobar", contributor: true, editor: true, admin: true, activated: true, activated_at: Time.zone.now)

Traitclass.create!([
  { :class_name => 'Contextual', :user_id => 1, :contextual => true }, 
  { :class_name => 'Taxonomic', :user_id => 1 }, 
  { :class_name => 'Ecological', :user_id => 1 }, 
  { :class_name => 'Organismal', :user_id => 1 }
  ])

Standard.create!([
  { :standard_name => 'Category', :standard_unit => 'cat', :standard_class => 'Nominal class', :user_id => 1 }, 
  { :standard_name => 'Name', :standard_unit => 'text', :standard_class => 'Nominal class', :user_id => 1 }, 
  { :standard_name => 'Degrees Celsius', :standard_unit => 'ºC', :standard_class => 'Base unit', :user_id => 1 }, 
  { :standard_name => 'Linear extension', :standard_unit => 'mm yr^-1', :standard_class => 'Complex derived unit', :user_id => 1 }, 
  { :standard_name => 'Meter', :standard_unit => 'm', :standard_class => 'Base unit', :user_id => 1 }, 
  { :standard_name => 'Count', :standard_unit => 'units', :standard_class => 'Base unit', :user_id => 1 }, 
  { :standard_name => 'Degrees', :standard_unit => 'deg', :standard_class => 'Base unit', :user_id => 1 }, 
  { :standard_name => 'Millimeter', :standard_unit => 'mm', :standard_class => 'Base unit', :user_id => 1 }, 
  { :standard_name => 'Density', :standard_unit => 'g cm^-3', :standard_class => 'Complex derived unit', :user_id => 1 }, 
  { :standard_name => 'Year', :standard_unit => 'yr', :standard_class => 'Datetime', :user_id => 1 }, 
  { :standard_name => 'Meter square', :standard_unit => 'm2', :standard_class => 'Simple derived unit', :user_id => 1 }, 
  { :standard_name => 'Kilogram', :standard_unit => 'kg', :standard_class => 'Base unit', :user_id => 1 }, 
  { :standard_name => 'Text', :standard_unit => 'text', :standard_class => 'Nominal class', :user_id => 1 } 
  ])

Valuetype.create!([
  {user_id: 1, value_type_name: "Raw value", value_type_description: "Value as measured by observer.", has_precision: false},
  {user_id: 1, value_type_name: "Mean", value_type_description: "The mean of raw values as measured by observer. Allows for precision.", has_precision: true}
])

Precisiontype.create!([
  {user_id: 1, precision_type_name: "Standard deviation", precision_type_description: "", has_range: false},
  {user_id: 1, precision_type_name: "Range", precision_type_description: "The minimum and maximum values measurements.", has_range: true}
])

Specie.create!([
  {user_id: 1, specie_name: "Acropora hyacinthus", specie_description: "Value as measured by observer."},
  {user_id: 1, specie_name: "Acropora gemmifera", specie_description: "The mean of raw values as measured by observer. Allows for precision."}
])

Trait.create!([
  {user_id: 1, trait_name: "Family", trait_description: "", traitclass_id: 2, standard_id: 1 },
  {user_id: 1, trait_name: "Depth", trait_description: "", traitclass_id: 1, standard_id: 5 },
  {user_id: 1, trait_name: "Growth rate", trait_description: "", traitclass_id: 4, standard_id: 4 },
  {user_id: 1, trait_name: "Skeletal density", trait_description: "", traitclass_id: 4, standard_id: 9 }
])

Location.create!([
  {user_id: 1, location_name: "Global Estimate", location_description: "", latitude: 0, longitude: 0 },
  {user_id: 1, location_name: "Lizard Island", location_description: "", latitude: -22, longitude: 149 }
])

Methodology.create!([
  {user_id: 1, methodology_name: "Depth gage" },
  {user_id: 1, methodology_name: "Photography" }
])

