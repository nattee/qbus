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

ActiveRecord::Schema.define(version: 2019_03_22_070630) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "number"
    t.bigint "user_id"
    t.integer "state"
    t.bigint "licensee_id"
    t.bigint "route_id"
    t.datetime "appointment_date"
    t.text "appointment_remark"
    t.bigint "appointment_user_id"
    t.text "award"
    t.text "award_remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
    t.string "contact_tel"
    t.integer "category"
    t.datetime "confirmed_date"
    t.datetime "submitted_date"
    t.datetime "approved_date"
    t.datetime "awarded_date"
    t.datetime "evaluated_date"
    t.integer "car_count"
    t.integer "trip_count"
    t.text "register_result"
    t.text "evaluation_result"
    t.string "license_no"
    t.index ["appointment_user_id"], name: "index_applications_on_appointment_user_id"
    t.index ["licensee_id"], name: "index_applications_on_licensee_id"
    t.index ["route_id"], name: "index_applications_on_route_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "criterium_attachment_id"
    t.bigint "application_id"
    t.integer "attachment_type"
    t.bigint "evidence_id"
    t.index ["application_id"], name: "index_attachments_on_application_id"
    t.index ["criterium_attachment_id"], name: "index_attachments_on_criterium_attachment_id"
    t.index ["evidence_id"], name: "index_attachments_on_evidence_id"
  end

  create_table "cars", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "plate"
    t.string "chassis"
    t.date "last_accident"
    t.text "last_accident_desc"
    t.string "car_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_id"
    t.index ["application_id"], name: "index_cars_on_application_id"
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

  create_table "criteria_evidences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "criterium_id"
    t.bigint "evidence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criterium_id"], name: "index_criteria_evidences_on_criterium_id"
    t.index ["evidence_id"], name: "index_criteria_evidences_on_evidence_id"
  end

  create_table "criteria_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "group_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "criterium_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "criterium_id"
    t.boolean "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criterium_id"], name: "index_criterium_attachments_on_criterium_id"
  end

  create_table "datafiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.date "month_year"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_datafiles_on_user_id"
  end

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "application_id"
    t.string "evaluator"
    t.date "evaluation_date"
    t.boolean "result"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "criterium_id"
    t.index ["application_id"], name: "index_evaluations_on_application_id"
    t.index ["criterium_id"], name: "index_evaluations_on_criterium_id"
  end

  create_table "evidences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "application_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_logs_on_application_id"
  end

  create_table "public_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "route_no"
    t.bigint "route_id"
    t.string "car_plate"
    t.bigint "car_id"
    t.string "licensee_name"
    t.bigint "licensee_id"
    t.text "comment"
    t.string "commenter"
    t.string "commenter_contact"
    t.string "commenter_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_public_comments_on_car_id"
    t.index ["licensee_id"], name: "index_public_comments_on_licensee_id"
    t.index ["route_id"], name: "index_public_comments_on_route_id"
  end

  create_table "routes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "start"
    t.string "destination"
    t.integer "car_count"
    t.string "route_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "route_no"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "roles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
  end

  create_table "violations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "car_id"
    t.integer "count"
    t.date "month_year"
    t.bigint "datafile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_violations_on_car_id"
    t.index ["datafile_id"], name: "index_violations_on_datafile_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attachments", "applications"
  add_foreign_key "attachments", "criterium_attachments"
  add_foreign_key "cars", "applications"
  add_foreign_key "criteria_evidences", "criteria"
  add_foreign_key "criteria_evidences", "evidences"
  add_foreign_key "datafiles", "users"
  add_foreign_key "logs", "applications"
  add_foreign_key "violations", "cars"
  add_foreign_key "violations", "datafiles"
end
