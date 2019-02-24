# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_24_092532) do

  create_table "applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "number"
    t.bigint "user_id"
    t.integer "state"
    t.bigint "licensee_id"
    t.bigint "route_id"
    t.string "category"
    t.datetime "appointment_date"
    t.text "appointment_remark"
    t.bigint "appointment_user_id"
    t.datetime "evaluation_finish_date"
    t.datetime "award_date"
    t.text "award"
    t.text "award_remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_user_id"], name: "index_applications_on_appointment_user_id"
    t.index ["licensee_id"], name: "index_applications_on_licensee_id"
    t.index ["route_id"], name: "index_applications_on_route_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "filename"
    t.integer "type"
    t.binary "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "plate"
    t.string "chassis"
    t.bigint "licensse_id"
    t.bigint "route_id"
    t.date "last_accident"
    t.text "last_accident_desc"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["licensse_id"], name: "index_cars_on_licensse_id"
    t.index ["route_id"], name: "index_cars_on_route_id"
  end

  create_table "criteria", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.text "description"
    t.text "approach"
    t.integer "weight"
    t.bigint "criteria_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criteria_group_id"], name: "index_criteria_on_criteria_group_id"
  end

  create_table "criteria_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "group_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "application_id"
    t.bigint "criteria_id"
    t.string "evaluator"
    t.date "evaluation_date"
    t.boolean "result"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_evaluations_on_application_id"
    t.index ["criteria_id"], name: "index_evaluations_on_criteria_id"
  end

  create_table "licensees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "license_no"
    t.date "license_expire"
    t.string "car_count"
    t.string "contact"
    t.string "contact_tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "start"
    t.string "destination"
    t.integer "car_count"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "roles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
