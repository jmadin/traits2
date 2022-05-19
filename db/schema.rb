# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2016_06_01_021815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issues", force: :cascade do |t|
    t.integer "user_id"
    t.integer "observation_id"
    t.text "issue_description"
    t.boolean "resolved"
    t.text "resolved_description"
    t.integer "resolved_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["observation_id"], name: "index_issues_on_observation_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.integer "user_id"
    t.string "location_name"
    t.decimal "latitude"
    t.decimal "longitude"
    t.text "location_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "approved"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.integer "user_id"
    t.integer "observation_id"
    t.integer "trait_id"
    t.integer "standard_id"
    t.integer "methodology_id"
    t.text "value"
    t.integer "valuetype_id"
    t.text "precision"
    t.integer "precisiontype_id"
    t.text "precision_upper"
    t.text "replicates"
    t.text "measurement_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["methodology_id"], name: "index_measurements_on_methodology_id"
    t.index ["observation_id"], name: "index_measurements_on_observation_id"
    t.index ["precisiontype_id"], name: "index_measurements_on_precisiontype_id"
    t.index ["standard_id"], name: "index_measurements_on_standard_id"
    t.index ["trait_id"], name: "index_measurements_on_trait_id"
    t.index ["user_id"], name: "index_measurements_on_user_id"
    t.index ["valuetype_id"], name: "index_measurements_on_valuetype_id"
  end

  create_table "methodologies", force: :cascade do |t|
    t.integer "user_id"
    t.string "methodology_name"
    t.text "methodology_description"
    t.boolean "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_methodologies_on_user_id"
  end

  create_table "methodologies_traits", id: false, force: :cascade do |t|
    t.integer "trait_id"
    t.integer "methodology_id"
  end

  create_table "observations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "specie_id"
    t.integer "location_id"
    t.integer "resource_id"
    t.integer "resource_secondary_id"
    t.boolean "access"
    t.boolean "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["location_id"], name: "index_observations_on_location_id"
    t.index ["resource_id"], name: "index_observations_on_resource_id"
    t.index ["resource_secondary_id"], name: "index_observations_on_resource_secondary_id"
    t.index ["specie_id"], name: "index_observations_on_specie_id"
    t.index ["user_id"], name: "index_observations_on_user_id"
  end

  create_table "precisiontypes", force: :cascade do |t|
    t.integer "user_id"
    t.string "precision_type_name"
    t.text "precision_type_description"
    t.boolean "has_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_precisiontypes_on_user_id"
  end

  create_table "releases", force: :cascade do |t|
    t.integer "user_id"
    t.string "release_code"
    t.datetime "release_date"
    t.string "release_link"
    t.text "release_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_releases_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.integer "user_id"
    t.text "author"
    t.integer "year"
    t.text "title"
    t.text "resource_type"
    t.text "doi_isbn"
    t.text "journal"
    t.text "volume_pages"
    t.text "resource_description"
    t.boolean "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_resources_on_user_id"
  end

  create_table "species", force: :cascade do |t|
    t.integer "user_id"
    t.string "specie_name"
    t.text "specie_description"
    t.string "aphia_id"
    t.boolean "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_species_on_user_id"
  end

  create_table "standards", force: :cascade do |t|
    t.integer "user_id"
    t.string "standard_name"
    t.string "standard_unit"
    t.string "standard_class"
    t.string "standard_description"
    t.boolean "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_standards_on_user_id"
  end

  create_table "synonyms", force: :cascade do |t|
    t.integer "specie_id"
    t.string "synonym_name"
    t.text "synonym_description"
    t.boolean "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["specie_id"], name: "index_synonyms_on_specie_id"
  end

  create_table "traitclasses", force: :cascade do |t|
    t.integer "user_id"
    t.string "class_name"
    t.text "class_description"
    t.boolean "contextual"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_traitclasses_on_user_id"
  end

  create_table "traits", force: :cascade do |t|
    t.integer "user_id"
    t.string "trait_name"
    t.text "trait_description"
    t.integer "traitclass_id"
    t.integer "standard_id"
    t.boolean "log_data"
    t.boolean "approved"
    t.boolean "released"
    t.boolean "hide"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["standard_id"], name: "index_traits_on_standard_id"
    t.index ["traitclass_id"], name: "index_traits_on_traitclass_id"
    t.index ["user_id"], name: "index_traits_on_user_id"
  end

  create_table "traits_traitvalues", id: false, force: :cascade do |t|
    t.integer "trait_id"
    t.integer "traitvalue_id"
  end

  create_table "traitvalues", force: :cascade do |t|
    t.string "value_name"
    t.integer "trait_id"
    t.text "value_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["trait_id"], name: "index_traitvalues_on_trait_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "institution"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "contributor", default: false
    t.boolean "editor", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "last_seen_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_digest"], name: "index_users_on_remember_digest"
  end

  create_table "valuetypes", force: :cascade do |t|
    t.integer "user_id"
    t.string "value_type_name"
    t.text "value_type_description"
    t.boolean "has_precision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_valuetypes_on_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.string "ip", limit: 255
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
