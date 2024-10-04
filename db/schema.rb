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

ActiveRecord::Schema[7.2].define(version: 2024_10_03_133816) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "employee_id", null: false
    t.bigint "day_assignment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_assignment_id"], name: "index_assignments_on_day_assignment_id"
    t.index ["employee_id"], name: "index_assignments_on_employee_id"
    t.index ["task_id"], name: "index_assignments_on_task_id"
  end

  create_table "day_assignments", force: :cascade do |t|
    t.string "hash_value"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_abilities", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "ability_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_employee_abilities_on_ability_id"
    t.index ["employee_id"], name: "index_employee_abilities_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.float "work_hours_per_day"
    t.integer "available_days", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_abilities", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "ability_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_task_abilities_on_ability_id"
    t.index ["task_id"], name: "index_task_abilities_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.datetime "date"
    t.float "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assignments", "day_assignments"
  add_foreign_key "assignments", "employees"
  add_foreign_key "assignments", "tasks"
  add_foreign_key "employee_abilities", "abilities"
  add_foreign_key "employee_abilities", "employees"
  add_foreign_key "task_abilities", "abilities"
  add_foreign_key "task_abilities", "tasks"
end
