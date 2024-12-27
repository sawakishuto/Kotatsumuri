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

ActiveRecord::Schema[7.2].define(version: 2024_12_27_043651) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "care_periods", force: :cascade do |t|
    t.bigint "care_schedule_id", null: false
    t.string "start"
    t.string "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_schedule_id"], name: "index_care_periods_on_care_schedule_id"
  end

  create_table "care_schedules", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_care_schedules_on_plant_id"
  end

  create_table "growth_conditions", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.string "light"
    t.string "soil"
    t.string "hardiness_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_growth_conditions_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "search_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "propagation_methods", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_propagation_methods_on_plant_id"
  end

  add_foreign_key "care_periods", "care_schedules"
  add_foreign_key "care_schedules", "plants"
  add_foreign_key "growth_conditions", "plants"
  add_foreign_key "propagation_methods", "plants"
end
