
puts "********Seeding Data Start************"

users = User.create!([
  {first_name: "Daniel", last_name: "Gomez Gras", email: "danielgomezgras@ucm.es", password: "corals", password_confirmation: "corals", contributor: true, editor: true, admin: true, activated: true, activated_at: Time.zone.now},
  {first_name: "Joshua", last_name: "Madin", email: "jmadin@hawaii.edu", password: "corals", password_confirmation: "corals", contributor: true, editor: true, admin: true, activated: true, activated_at: Time.zone.now}
])

Valuetype.create!([
  {user_id: 1, value_type_name: "Raw value", value_type_description: "Value as measured by observer.", has_precision: false},
  {user_id: 1, value_type_name: "Mean", value_type_description: "The mean of raw values as measured by observer. Allows for precision.", has_precision: true},
  {user_id: 1, value_type_name: "Median", value_type_description: "The median of raw values or range as measured by observer. Allows for precision.", has_precision: true}
])

Precisiontype.create!([
  {user_id: 1, precision_type_name: "Standard deviation", precision_type_description: "", has_range: false},
  {user_id: 1, precision_type_name: "Range", precision_type_description: "The minimum and maximum values measurements.", has_range: true}
])
