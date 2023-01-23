
puts "********Seeding Data Start************"

users = User.create!(first_name: "Dr", last_name: "Admin", email: "admin@traits.org", password: "foobar", password_confirmation: "foobar", contributor: true, editor: true, admin: true, activated: true, activated_at: Time.zone.now)

Valuetype.create!([
  {user_id: 1, value_type_name: "Raw value", value_type_description: "Value as measured by observer.", has_precision: false},
  {user_id: 1, value_type_name: "Mean", value_type_description: "The mean of raw values as measured by observer. Allows for precision.", has_precision: true}
])

Precisiontype.create!([
  {user_id: 1, precision_type_name: "Standard deviation", precision_type_description: "", has_range: false},
  {user_id: 1, precision_type_name: "Range", precision_type_description: "The minimum and maximum values measurements.", has_range: true}
])
