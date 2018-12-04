# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20181204194638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "tablefunc"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "picture"
    t.string   "website_link"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "picture"
    t.string   "website_link"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "properties"
    t.datetime "time"
  end

  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "properties"
    t.datetime "time"
  end

  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "benefit_responses", force: :cascade do |t|
    t.integer  "conference_id"
    t.integer  "sponsorship_id"
    t.integer  "benefit_id"
    t.text     "text_response"
    t.string   "file_response"
    t.boolean  "bool_response"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "benefit_responses", ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true, using: :btree
  add_index "benefit_responses", ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true, using: :btree

  create_table "benefit_responses", force: :cascade do |t|
    t.integer  "conference_id"
    t.integer  "sponsorship_id"
    t.integer  "benefit_id"
    t.text     "text_response"
    t.string   "file_response"
    t.boolean  "bool_response"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "benefit_responses", ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true, using: :btree
  add_index "benefit_responses", ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true, using: :btree

  create_table "benefits", force: :cascade do |t|
    t.string   "name"
    t.integer  "conference_id"
    t.integer  "category"
    t.integer  "value_type"
    t.text     "description"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "benefits", ["conference_id"], name: "index_benefits_on_conference_id", using: :btree
  add_index "benefits", ["conference_id"], name: "index_benefits_on_conference_id", using: :btree

  create_table "benefits", force: :cascade do |t|
    t.string   "name"
    t.integer  "conference_id"
    t.integer  "category"
    t.integer  "value_type"
    t.text     "description"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "benefits", ["conference_id"], name: "index_benefits_on_conference_id", using: :btree
  add_index "benefits", ["conference_id"], name: "index_benefits_on_conference_id", using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.integer  "conference_id"
    t.string   "name"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer  "conference_id"
    t.string   "name"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cfps", force: :cascade do |t|
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
  end

  create_table "cfps", force: :cascade do |t|
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
  end

  create_table "code_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "code_types", ["title"], name: "index_code_types_on_title", unique: true, using: :btree
  add_index "code_types", ["title"], name: "index_code_types_on_title", unique: true, using: :btree

  create_table "code_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "code_types", ["title"], name: "index_code_types_on_title", unique: true, using: :btree
  add_index "code_types", ["title"], name: "index_code_types_on_title", unique: true, using: :btree

  create_table "codes", force: :cascade do |t|
    t.string   "name"
    t.integer  "code_type_id"
    t.integer  "conference_id"
    t.integer  "discount"
    t.integer  "max_uses",      default: 0, null: false
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "codes", ["conference_id", "name"], name: "index_codes_on_conference_id_and_name", unique: true, using: :btree
  add_index "codes", ["conference_id"], name: "index_codes_on_conference_id", using: :btree
  add_index "codes", ["name"], name: "index_codes_on_name", unique: true, using: :btree
  add_index "codes", ["sponsor_id"], name: "index_codes_on_sponsor_id", using: :btree
  add_index "codes", ["sponsor_id"], name: "index_codes_on_sponsor_id", using: :btree

  create_table "codes", force: :cascade do |t|
    t.string   "name"
    t.integer  "code_type_id"
    t.integer  "conference_id"
    t.integer  "discount"
    t.integer  "max_uses",      default: 0, null: false
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "codes", ["conference_id", "name"], name: "index_codes_on_conference_id_and_name", unique: true, using: :btree
  add_index "codes", ["conference_id"], name: "index_codes_on_conference_id", using: :btree
  add_index "codes", ["name"], name: "index_codes_on_name", unique: true, using: :btree
  add_index "codes", ["sponsor_id"], name: "index_codes_on_sponsor_id", using: :btree
  add_index "codes", ["sponsor_id"], name: "index_codes_on_sponsor_id", using: :btree

  create_table "codes_tickets", id: false, force: :cascade do |t|
    t.integer "code_id"
    t.integer "ticket_id"
  end

  add_index "codes_tickets", ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true, using: :btree
  add_index "codes_tickets", ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true, using: :btree

  create_table "codes_tickets", id: false, force: :cascade do |t|
    t.integer "code_id"
    t.integer "ticket_id"
  end

  add_index "codes_tickets", ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true, using: :btree
  add_index "codes_tickets", ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "commercials", force: :cascade do |t|
    t.string   "commercial_id"
    t.string   "commercial_type"
    t.integer  "commercialable_id"
    t.string   "commercialable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "commercials", force: :cascade do |t|
    t.string   "commercial_id"
    t.string   "commercial_type"
    t.integer  "commercialable_id"
    t.string   "commercialable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "conference_groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conference_team_members", force: :cascade do |t|
    t.integer "conference_id",           null: false
    t.integer "refinery_team_member_id", null: false
    t.integer "position",                null: false
  end

  add_index "conference_team_members", ["conference_id"], name: "index_conference_team_members_on_conference_id", using: :btree

  create_table "conferences", force: :cascade do |t|
    t.string   "guid",                                       null: false
    t.string   "title",                                      null: false
    t.string   "short_title",                                null: false
    t.string   "timezone",                                   null: false
    t.date     "start_date",                                 null: false
    t.date     "end_date",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.integer  "revision"
    t.boolean  "use_vpositions",             default: false
    t.boolean  "use_vdays",                  default: false
    t.boolean  "use_volunteers"
    t.string   "color"
    t.text     "events_per_week"
    t.text     "description"
    t.integer  "registration_limit",         default: 0
    t.string   "picture"
    t.integer  "start_hour",                 default: 9
    t.integer  "end_hour",                   default: 20
    t.boolean  "require_itinerary"
    t.boolean  "use_pg_flow",                default: true
    t.string   "background_file_name"
    t.string   "default_currency",           default: "USD"
    t.string   "braintree_merchant_account"
    t.integer  "ticket_layout",              default: 0
    t.text     "extended_description"
    t.integer  "conference_group_id"
  end

  create_table "conferences", force: :cascade do |t|
    t.string   "guid",                                       null: false
    t.string   "title",                                      null: false
    t.string   "short_title",                                null: false
    t.string   "timezone",                                   null: false
    t.date     "start_date",                                 null: false
    t.date     "end_date",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.integer  "revision"
    t.boolean  "use_vpositions",             default: false
    t.boolean  "use_vdays",                  default: false
    t.boolean  "use_volunteers"
    t.string   "color"
    t.text     "events_per_week"
    t.text     "description"
    t.integer  "registration_limit",         default: 0
    t.string   "picture"
    t.integer  "start_hour",                 default: 9
    t.integer  "end_hour",                   default: 20
    t.boolean  "require_itinerary"
    t.boolean  "use_pg_flow",                default: true
    t.string   "background_file_name"
    t.string   "default_currency",           default: "USD"
    t.string   "braintree_merchant_account"
    t.integer  "ticket_layout",              default: 0
    t.text     "extended_description"
    t.integer  "conference_group_id"
  end

  create_table "conferences_codes", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "code_id"
  end

  add_index "conferences_codes", ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true, using: :btree
  add_index "conferences_codes", ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true, using: :btree

  create_table "conferences_codes", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "code_id"
  end

  add_index "conferences_codes", ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true, using: :btree
  add_index "conferences_codes", ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true, using: :btree

  create_table "conferences_policies", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "policy_id"
  end

  add_index "conferences_policies", ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true, using: :btree
  add_index "conferences_policies", ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true, using: :btree

  create_table "conferences_policies", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "policy_id"
  end

  add_index "conferences_policies", ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true, using: :btree
  add_index "conferences_policies", ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true, using: :btree

  create_table "conferences_questions", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "question_id"
  end

  create_table "conferences_questions", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "question_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "social_tag"
    t.string   "email"
    t.string   "facebook"
    t.string   "googleplus"
    t.string   "twitter"
    t.string   "instagram"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sponsor_email"
    t.string   "name"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "social_tag"
    t.string   "email"
    t.string   "facebook"
    t.string   "googleplus"
    t.string   "twitter"
    t.string   "instagram"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sponsor_email"
    t.string   "name"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "difficulty_levels", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
  end

  create_table "difficulty_levels", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
  end

  create_table "email_settings", force: :cascade do |t|
    t.integer  "conference_id"
    t.boolean  "send_on_registration",                          default: false
    t.boolean  "send_on_accepted",                              default: false
    t.boolean  "send_on_rejected",                              default: false
    t.boolean  "send_on_confirmed_without_registration",        default: false
    t.text     "registration_body"
    t.text     "accepted_body"
    t.text     "rejected_body"
    t.text     "confirmed_without_registration_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "registration_subject"
    t.string   "accepted_subject"
    t.string   "rejected_subject"
    t.string   "confirmed_without_registration_subject"
    t.boolean  "send_on_conference_dates_updated",              default: false
    t.string   "conference_dates_updated_subject"
    t.text     "conference_dates_updated_body"
    t.boolean  "send_on_conference_registration_dates_updated", default: false
    t.string   "conference_registration_dates_updated_subject"
    t.text     "conference_registration_dates_updated_body"
    t.boolean  "send_on_venue_updated",                         default: false
    t.string   "venue_updated_subject"
    t.text     "venue_updated_body"
    t.boolean  "send_on_cfp_dates_updated",                     default: false
    t.boolean  "send_on_program_schedule_public",               default: false
    t.string   "program_schedule_public_subject"
    t.string   "cfp_dates_updated_subject"
    t.text     "program_schedule_public_body"
    t.text     "cfp_dates_updated_body"
  end

  create_table "email_settings", force: :cascade do |t|
    t.integer  "conference_id"
    t.boolean  "send_on_registration",                          default: false
    t.boolean  "send_on_accepted",                              default: false
    t.boolean  "send_on_rejected",                              default: false
    t.boolean  "send_on_confirmed_without_registration",        default: false
    t.text     "registration_body"
    t.text     "accepted_body"
    t.text     "rejected_body"
    t.text     "confirmed_without_registration_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "registration_subject"
    t.string   "accepted_subject"
    t.string   "rejected_subject"
    t.string   "confirmed_without_registration_subject"
    t.boolean  "send_on_conference_dates_updated",              default: false
    t.string   "conference_dates_updated_subject"
    t.text     "conference_dates_updated_body"
    t.boolean  "send_on_conference_registration_dates_updated", default: false
    t.string   "conference_registration_dates_updated_subject"
    t.text     "conference_registration_dates_updated_body"
    t.boolean  "send_on_venue_updated",                         default: false
    t.string   "venue_updated_subject"
    t.text     "venue_updated_body"
    t.boolean  "send_on_cfp_dates_updated",                     default: false
    t.boolean  "send_on_program_schedule_public",               default: false
    t.string   "program_schedule_public_subject"
    t.string   "cfp_dates_updated_subject"
    t.text     "program_schedule_public_body"
    t.text     "cfp_dates_updated_body"
  end

  create_table "event_schedules", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "schedule_id"
    t.integer  "room_id"
    t.datetime "start_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "event_schedules", ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true, using: :btree
  add_index "event_schedules", ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true, using: :btree
  add_index "event_schedules", ["event_id"], name: "index_event_schedules_on_event_id", using: :btree
  add_index "event_schedules", ["event_id"], name: "index_event_schedules_on_event_id", using: :btree
  add_index "event_schedules", ["room_id"], name: "index_event_schedules_on_room_id", using: :btree
  add_index "event_schedules", ["room_id"], name: "index_event_schedules_on_room_id", using: :btree
  add_index "event_schedules", ["schedule_id"], name: "index_event_schedules_on_schedule_id", using: :btree
  add_index "event_schedules", ["schedule_id"], name: "index_event_schedules_on_schedule_id", using: :btree

  create_table "event_schedules", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "schedule_id"
    t.integer  "room_id"
    t.datetime "start_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "event_schedules", ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true, using: :btree
  add_index "event_schedules", ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true, using: :btree
  add_index "event_schedules", ["event_id"], name: "index_event_schedules_on_event_id", using: :btree
  add_index "event_schedules", ["event_id"], name: "index_event_schedules_on_event_id", using: :btree
  add_index "event_schedules", ["room_id"], name: "index_event_schedules_on_room_id", using: :btree
  add_index "event_schedules", ["room_id"], name: "index_event_schedules_on_room_id", using: :btree
  add_index "event_schedules", ["schedule_id"], name: "index_event_schedules_on_schedule_id", using: :btree
  add_index "event_schedules", ["schedule_id"], name: "index_event_schedules_on_schedule_id", using: :btree

  create_table "event_types", force: :cascade do |t|
    t.string  "title",                                   null: false
    t.integer "length",                  default: 30
    t.integer "minimum_abstract_length", default: 0
    t.integer "maximum_abstract_length", default: 500
    t.string  "color"
    t.string  "description"
    t.integer "program_id"
    t.boolean "internal_event",          default: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string  "title",                                   null: false
    t.integer "length",                  default: 30
    t.integer "minimum_abstract_length", default: 0
    t.integer "maximum_abstract_length", default: 500
    t.string  "color"
    t.string  "description"
    t.integer "program_id"
    t.boolean "internal_event",          default: false
  end

  create_table "event_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "event_role",   default: "participant", null: false
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_highlight", default: false
  end

  create_table "event_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "event_role",   default: "participant", null: false
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_highlight", default: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "guid",                                         null: false
    t.integer  "event_type_id"
    t.string   "title",                                        null: false
    t.string   "subtitle"
    t.string   "state",                        default: "new", null: false
    t.string   "progress",                     default: "new", null: false
    t.string   "language"
    t.datetime "start_time"
    t.text     "abstract"
    t.text     "description"
    t.boolean  "public",                       default: true
    t.text     "proposal_additional_speakers"
    t.integer  "track_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "require_registration"
    t.integer  "difficulty_level_id"
    t.integer  "week"
    t.boolean  "is_highlight",                 default: false
    t.integer  "program_id"
    t.integer  "max_attendees"
    t.string   "slug"
    t.integer  "ticket_id"
    t.string   "document"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["ticket_id"], name: "index_events_on_ticket_id", using: :btree
  add_index "events", ["ticket_id"], name: "index_events_on_ticket_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "guid",                                         null: false
    t.integer  "event_type_id"
    t.string   "title",                                        null: false
    t.string   "subtitle"
    t.string   "state",                        default: "new", null: false
    t.string   "progress",                     default: "new", null: false
    t.string   "language"
    t.datetime "start_time"
    t.text     "abstract"
    t.text     "description"
    t.boolean  "public",                       default: true
    t.text     "proposal_additional_speakers"
    t.integer  "track_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "require_registration"
    t.integer  "difficulty_level_id"
    t.integer  "week"
    t.boolean  "is_highlight",                 default: false
    t.integer  "program_id"
    t.integer  "max_attendees"
    t.string   "slug"
    t.integer  "ticket_id"
    t.string   "document"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["ticket_id"], name: "index_events_on_ticket_id", using: :btree
  add_index "events", ["ticket_id"], name: "index_events_on_ticket_id", using: :btree

  create_table "events_back", id: false, force: :cascade do |t|
    t.integer  "id"
    t.string   "guid"
    t.integer  "event_type_id"
    t.string   "title"
    t.string   "subtitle"
    t.string   "state"
    t.string   "progress"
    t.string   "language"
    t.datetime "start_time"
    t.text     "abstract"
    t.text     "description"
    t.boolean  "public"
    t.text     "proposal_additional_speakers"
    t.integer  "track_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "require_registration"
    t.integer  "difficulty_level_id"
    t.integer  "week"
    t.boolean  "is_highlight"
    t.integer  "program_id"
    t.integer  "max_attendees"
  end

  create_table "events_registrations", force: :cascade do |t|
    t.integer  "registration_id"
    t.integer  "event_id"
    t.boolean  "attended",        default: false, null: false
    t.datetime "created_at"
  end

  create_table "events_registrations", force: :cascade do |t|
    t.integer  "registration_id"
    t.integer  "event_id"
    t.boolean  "attended",        default: false, null: false
    t.datetime "created_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "lodgings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website_link"
    t.integer  "conference_id"
    t.string   "picture"
  end

  create_table "lodgings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website_link"
    t.integer  "conference_id"
    t.string   "picture"
  end

  create_table "openids", force: :cascade do |t|
    t.string   "provider"
    t.string   "email"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "openids", force: :cascade do |t|
    t.string   "provider"
    t.string   "email"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer  "conference_id",              null: false
    t.string   "environment",                null: false
    t.string   "gateway",                    null: false
    t.string   "braintree_environment"
    t.string   "braintree_merchant_id"
    t.string   "braintree_public_key"
    t.string   "braintree_private_key"
    t.string   "braintree_merchant_account"
    t.string   "payu_store_name"
    t.string   "payu_store_id"
    t.string   "payu_webservice_name"
    t.string   "payu_webservice_password"
    t.string   "payu_signature_key"
    t.string   "payu_service_domain"
    t.string   "stripe_publishable_key"
    t.string   "stripe_secret_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_methods", ["conference_id", "environment"], name: "index_payment_methods_on_conference_id_and_environment", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "last4"
    t.integer  "amount"
    t.string   "authorization_code"
    t.integer  "status",             default: 0, null: false
    t.integer  "user_id",                        null: false
    t.integer  "conference_id",                  null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "reference"
  end

  add_index "payments", ["reference"], name: "index_payments_on_reference", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "last4"
    t.integer  "amount"
    t.string   "authorization_code"
    t.integer  "status",             default: 0, null: false
    t.integer  "user_id",                        null: false
    t.integer  "conference_id",                  null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "reference"
  end

  add_index "payments", ["reference"], name: "index_payments_on_reference", unique: true, using: :btree

  create_table "physical_tickets", force: :cascade do |t|
    t.integer  "ticket_purchase_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "token"
    t.integer  "user_id",            null: false
    t.integer  "event_id"
    t.integer  "registration_id",    null: false
    t.string   "pending_assignment"
  end

  add_index "physical_tickets", ["registration_id"], name: "index_physical_tickets_on_registration_id", using: :btree
  add_index "physical_tickets", ["registration_id"], name: "index_physical_tickets_on_registration_id", using: :btree
  add_index "physical_tickets", ["token"], name: "index_physical_tickets_on_token", unique: true, using: :btree
  add_index "physical_tickets", ["token"], name: "index_physical_tickets_on_token", unique: true, using: :btree
  add_index "physical_tickets", ["user_id"], name: "index_physical_tickets_on_user_id", using: :btree
  add_index "physical_tickets", ["user_id"], name: "index_physical_tickets_on_user_id", using: :btree

  create_table "physical_tickets", force: :cascade do |t|
    t.integer  "ticket_purchase_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "token"
    t.integer  "user_id",            null: false
    t.integer  "event_id"
    t.integer  "registration_id",    null: false
    t.string   "pending_assignment"
  end

  add_index "physical_tickets", ["registration_id"], name: "index_physical_tickets_on_registration_id", using: :btree
  add_index "physical_tickets", ["registration_id"], name: "index_physical_tickets_on_registration_id", using: :btree
  add_index "physical_tickets", ["token"], name: "index_physical_tickets_on_token", unique: true, using: :btree
  add_index "physical_tickets", ["token"], name: "index_physical_tickets_on_token", unique: true, using: :btree
  add_index "physical_tickets", ["user_id"], name: "index_physical_tickets_on_user_id", using: :btree
  add_index "physical_tickets", ["user_id"], name: "index_physical_tickets_on_user_id", using: :btree

  create_table "policies", force: :cascade do |t|
    t.string   "title"
    t.integer  "conference_id"
    t.boolean  "global"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "policies", force: :cascade do |t|
    t.string   "title"
    t.integer  "conference_id"
    t.boolean  "global"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", force: :cascade do |t|
    t.integer  "conference_id"
    t.integer  "survey_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "polls", ["conference_id"], name: "index_polls_on_conference_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.integer  "conference_id"
    t.integer  "rating",               default: 0
    t.boolean  "schedule_public",      default: false
    t.boolean  "schedule_fluid",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "languages"
    t.boolean  "blind_voting",         default: false
    t.datetime "voting_start_date"
    t.datetime "voting_end_date"
    t.integer  "selected_schedule_id"
  end

  add_index "programs", ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id", using: :btree
  add_index "programs", ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.integer  "conference_id"
    t.integer  "rating",               default: 0
    t.boolean  "schedule_public",      default: false
    t.boolean  "schedule_fluid",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "languages"
    t.boolean  "blind_voting",         default: false
    t.datetime "voting_start_date"
    t.datetime "voting_end_date"
    t.integer  "selected_schedule_id"
  end

  add_index "programs", ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id", using: :btree
  add_index "programs", ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id", using: :btree

  create_table "qanswers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qanswers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qanswers_registrations", id: false, force: :cascade do |t|
    t.integer "registration_id", null: false
    t.integer "qanswer_id",      null: false
  end

  create_table "qanswers_registrations", id: false, force: :cascade do |t|
    t.integer "registration_id", null: false
    t.integer "qanswer_id",      null: false
  end

  create_table "question_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "question_type_id"
    t.integer  "conference_id"
    t.boolean  "global"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "question_type_id"
    t.integer  "conference_id"
    t.boolean  "global"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_authentication_devise_roles", force: :cascade do |t|
    t.string "title"
  end

  create_table "refinery_authentication_devise_roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_authentication_devise_roles_users", ["role_id", "user_id"], name: "refinery_roles_users_role_id_user_id", using: :btree
  add_index "refinery_authentication_devise_roles_users", ["user_id", "role_id"], name: "refinery_roles_users_user_id_role_id", using: :btree

  create_table "refinery_authentication_devise_user_plugins", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_authentication_devise_user_plugins", ["name"], name: "index_refinery_authentication_devise_user_plugins_on_name", using: :btree
  add_index "refinery_authentication_devise_user_plugins", ["user_id", "name"], name: "refinery_user_plugins_user_id_name", unique: true, using: :btree

  create_table "refinery_authentication_devise_users", force: :cascade do |t|
    t.string   "username",               null: false
    t.string   "email",                  null: false
    t.string   "encrypted_password",     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "full_name"
  end

  add_index "refinery_authentication_devise_users", ["id"], name: "index_refinery_authentication_devise_users_on_id", using: :btree
  add_index "refinery_authentication_devise_users", ["slug"], name: "index_refinery_authentication_devise_users_on_slug", using: :btree

  create_table "refinery_blog_categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "refinery_blog_categories", ["id"], name: "index_refinery_blog_categories_on_id", using: :btree
  add_index "refinery_blog_categories", ["slug"], name: "index_refinery_blog_categories_on_slug", using: :btree

  create_table "refinery_blog_categories_blog_posts", force: :cascade do |t|
    t.integer "blog_category_id"
    t.integer "blog_post_id"
  end

  add_index "refinery_blog_categories_blog_posts", ["blog_category_id", "blog_post_id"], name: "index_blog_categories_blog_posts_on_bc_and_bp", using: :btree

  create_table "refinery_blog_category_translations", force: :cascade do |t|
    t.integer  "refinery_blog_category_id", null: false
    t.string   "locale",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "title"
    t.string   "slug"
  end

  add_index "refinery_blog_category_translations", ["locale"], name: "index_refinery_blog_category_translations_on_locale", using: :btree
  add_index "refinery_blog_category_translations", ["refinery_blog_category_id"], name: "index_a0315945e6213bbe0610724da0ee2de681b77c31", using: :btree

  create_table "refinery_blog_comments", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.boolean  "spam"
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_blog_comments", ["blog_post_id"], name: "index_refinery_blog_comments_on_blog_post_id", using: :btree
  add_index "refinery_blog_comments", ["id"], name: "index_refinery_blog_comments_on_id", using: :btree

  create_table "refinery_blog_post_translations", force: :cascade do |t|
    t.integer  "refinery_blog_post_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "body"
    t.text     "custom_teaser"
    t.string   "custom_url"
    t.string   "slug"
    t.string   "title"
  end

  add_index "refinery_blog_post_translations", ["locale"], name: "index_refinery_blog_post_translations_on_locale", using: :btree
  add_index "refinery_blog_post_translations", ["refinery_blog_post_id"], name: "index_refinery_blog_post_translations_on_refinery_blog_post_id", using: :btree

  create_table "refinery_blog_posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "draft"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "custom_url"
    t.text     "custom_teaser"
    t.string   "source_url"
    t.string   "source_url_title"
    t.integer  "access_count",     default: 0
    t.string   "slug"
    t.integer  "image_id"
  end

  add_index "refinery_blog_posts", ["access_count"], name: "index_refinery_blog_posts_on_access_count", using: :btree
  add_index "refinery_blog_posts", ["id"], name: "index_refinery_blog_posts_on_id", using: :btree
  add_index "refinery_blog_posts", ["slug"], name: "index_refinery_blog_posts_on_slug", using: :btree

  create_table "refinery_dynamicfields_dynamicfields", force: :cascade do |t|
    t.string   "criteria",    default: "page_layout"
    t.string   "page_layout"
    t.string   "page_id"
    t.string   "model_title"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_dynamicfields_dynamicform_associations", force: :cascade do |t|
    t.integer "dynamicfield_id"
    t.integer "page_id"
  end

  create_table "refinery_dynamicfields_dynamicform_fields", force: :cascade do |t|
    t.integer  "dynamicfield_id"
    t.string   "field_id"
    t.string   "field_label"
    t.string   "field_type"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_dynamicfields_dynamicform_values", force: :cascade do |t|
    t.integer "dynamicform_field_id"
    t.integer "dynamicform_association_id"
    t.text    "text_value"
    t.integer "resource_id"
    t.integer "image_id"
    t.string  "string_value"
  end

  create_table "refinery_image_translations", force: :cascade do |t|
    t.integer  "refinery_image_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "image_alt"
    t.string   "image_title"
  end

  add_index "refinery_image_translations", ["locale"], name: "index_refinery_image_translations_on_locale", using: :btree
  add_index "refinery_image_translations", ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id", using: :btree

  create_table "refinery_images", force: :cascade do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_title"
    t.string   "image_alt"
  end

  create_table "refinery_page_part_translations", force: :cascade do |t|
    t.integer  "refinery_page_part_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "body"
  end

  add_index "refinery_page_part_translations", ["locale"], name: "index_refinery_page_part_translations_on_locale", using: :btree
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id", using: :btree

  create_table "refinery_page_parts", force: :cascade do |t|
    t.integer  "refinery_page_id"
    t.string   "slug"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "refinery_page_parts", ["id"], name: "index_refinery_page_parts_on_id", using: :btree
  add_index "refinery_page_parts", ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id", using: :btree

  create_table "refinery_page_translations", force: :cascade do |t|
    t.integer  "refinery_page_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
  end

  add_index "refinery_page_translations", ["locale"], name: "index_refinery_page_translations_on_locale", using: :btree
  add_index "refinery_page_translations", ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id", using: :btree

  create_table "refinery_pages", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.string   "custom_slug"
    t.boolean  "show_in_menu",        default: true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           default: true
    t.boolean  "draft",               default: false
    t.boolean  "skip_to_first_child", default: false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_pages", ["depth"], name: "index_refinery_pages_on_depth", using: :btree
  add_index "refinery_pages", ["id"], name: "index_refinery_pages_on_id", using: :btree
  add_index "refinery_pages", ["lft"], name: "index_refinery_pages_on_lft", using: :btree
  add_index "refinery_pages", ["parent_id"], name: "index_refinery_pages_on_parent_id", using: :btree
  add_index "refinery_pages", ["rgt"], name: "index_refinery_pages_on_rgt", using: :btree

  create_table "refinery_resource_translations", force: :cascade do |t|
    t.integer  "refinery_resource_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "resource_title"
  end

  add_index "refinery_resource_translations", ["locale"], name: "index_refinery_resource_translations_on_locale", using: :btree
  add_index "refinery_resource_translations", ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id", using: :btree

  create_table "refinery_resources", force: :cascade do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_settings", force: :cascade do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable",     default: true
    t.string   "scoping"
    t.boolean  "restricted",      default: false
    t.string   "form_value_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "title"
  end

  add_index "refinery_settings", ["name"], name: "index_refinery_settings_on_name", using: :btree

  create_table "refinery_sponsors", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "logo_id"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sponsorship_level_id"
  end

  add_index "refinery_sponsors", ["sponsorship_level_id"], name: "index_refinery_sponsors_on_sponsorship_level_id", using: :btree

  create_table "refinery_sponsors_sponsorship_levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_team_members", force: :cascade do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "role"
    t.integer  "photo_id"
    t.text     "description"
    t.string   "twitter"
    t.string   "linkedin"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registration_periods", force: :cascade do |t|
    t.integer  "conference_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "early_bird_date"
  end

  create_table "registration_periods", force: :cascade do |t|
    t.integer  "conference_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "early_bird_date"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "conference_id"
    t.datetime "arrival"
    t.datetime "departure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "other_special_needs"
    t.boolean  "attended",            default: false
    t.boolean  "volunteer"
    t.integer  "user_id"
    t.integer  "week"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "conference_id"
    t.datetime "arrival"
    t.datetime "departure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "other_special_needs"
    t.boolean  "attended",            default: false
    t.boolean  "volunteer"
    t.integer  "user_id"
    t.integer  "week"
  end

  create_table "registrations_vchoices", id: false, force: :cascade do |t|
    t.integer "registration_id"
    t.integer "vchoice_id"
  end

  create_table "registrations_vchoices", id: false, force: :cascade do |t|
    t.integer "registration_id"
    t.integer "vchoice_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "resource_id"
    t.string   "resource_type"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "resource_id"
    t.string   "resource_type"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string  "guid",     null: false
    t.string  "name",     null: false
    t.integer "size"
    t.integer "venue_id", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string  "guid",     null: false
    t.string  "name",     null: false
    t.integer "size"
    t.integer "venue_id", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "schedules", ["program_id"], name: "index_schedules_on_program_id", using: :btree
  add_index "schedules", ["program_id"], name: "index_schedules_on_program_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "schedules", ["program_id"], name: "index_schedules_on_program_id", using: :btree
  add_index "schedules", ["program_id"], name: "index_schedules_on_program_id", using: :btree

  create_table "seo_meta", force: :cascade do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.text     "meta_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "seo_meta", ["id"], name: "index_seo_meta_on_id", using: :btree
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta", using: :btree

  create_table "splashpages", force: :cascade do |t|
    t.integer  "conference_id"
    t.boolean  "public"
    t.boolean  "include_tracks"
    t.boolean  "include_program"
    t.boolean  "include_social_media"
    t.boolean  "include_venue"
    t.boolean  "include_tickets"
    t.boolean  "include_registrations"
    t.boolean  "include_sponsors"
    t.boolean  "include_lodgings"
    t.string   "banner_photo_file_name"
    t.string   "banner_photo_content_type"
    t.integer  "banner_photo_file_size"
    t.datetime "banner_photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "include_cfp",               default: false
    t.boolean  "include_activities",        default: false
  end

  create_table "splashpages", force: :cascade do |t|
    t.integer  "conference_id"
    t.boolean  "public"
    t.boolean  "include_tracks"
    t.boolean  "include_program"
    t.boolean  "include_social_media"
    t.boolean  "include_venue"
    t.boolean  "include_tickets"
    t.boolean  "include_registrations"
    t.boolean  "include_sponsors"
    t.boolean  "include_lodgings"
    t.string   "banner_photo_file_name"
    t.string   "banner_photo_content_type"
    t.integer  "banner_photo_file_size"
    t.datetime "banner_photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "include_cfp",               default: false
    t.boolean  "include_activities",        default: false
  end

  create_table "sponsors", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website_url"
    t.string   "logo_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "short_name"
  end

  add_index "sponsors", ["short_name"], name: "index_sponsors_on_short_name", unique: true, using: :btree
  add_index "sponsors", ["short_name"], name: "index_sponsors_on_short_name", unique: true, using: :btree

  create_table "sponsors", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website_url"
    t.string   "logo_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "short_name"
  end

  add_index "sponsors", ["short_name"], name: "index_sponsors_on_short_name", unique: true, using: :btree
  add_index "sponsors", ["short_name"], name: "index_sponsors_on_short_name", unique: true, using: :btree

  create_table "sponsors_backup", id: false, force: :cascade do |t|
    t.integer  "id"
    t.string   "name"
    t.text     "description"
    t.string   "website_url"
    t.string   "logo_file_name"
    t.integer  "sponsorship_level_id"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  create_table "sponsors_users", id: false, force: :cascade do |t|
    t.integer "sponsor_id"
    t.integer "user_id"
  end

  add_index "sponsors_users", ["user_id"], name: "index_sponsors_users_on_user_id", unique: true, using: :btree
  add_index "sponsors_users", ["user_id"], name: "index_sponsors_users_on_user_id", unique: true, using: :btree

  create_table "sponsors_users", id: false, force: :cascade do |t|
    t.integer "sponsor_id"
    t.integer "user_id"
  end

  add_index "sponsors_users", ["user_id"], name: "index_sponsors_users_on_user_id", unique: true, using: :btree
  add_index "sponsors_users", ["user_id"], name: "index_sponsors_users_on_user_id", unique: true, using: :btree

  create_table "sponsorship_infos", force: :cascade do |t|
    t.text     "description"
    t.integer  "conference_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "prospectus"
    t.string   "liaison_email"
    t.string   "manual"
  end

  add_index "sponsorship_infos", ["conference_id"], name: "index_sponsorship_infos_on_conference_id", using: :btree
  add_index "sponsorship_infos", ["conference_id"], name: "index_sponsorship_infos_on_conference_id", using: :btree

  create_table "sponsorship_infos", force: :cascade do |t|
    t.text     "description"
    t.integer  "conference_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "prospectus"
    t.string   "liaison_email"
    t.string   "manual"
  end

  add_index "sponsorship_infos", ["conference_id"], name: "index_sponsorship_infos_on_conference_id", using: :btree
  add_index "sponsorship_infos", ["conference_id"], name: "index_sponsorship_infos_on_conference_id", using: :btree

  create_table "sponsorship_levels", force: :cascade do |t|
    t.string   "title"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "sponsorship_levels", force: :cascade do |t|
    t.string   "title"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "sponsorship_levels_benefits", force: :cascade do |t|
    t.integer  "sponsorship_level_id"
    t.integer  "benefit_id"
    t.integer  "code_type_id"
    t.integer  "max_uses"
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorship_levels_benefits", ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id", using: :btree
  add_index "sponsorship_levels_benefits", ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id", using: :btree

  create_table "sponsorship_levels_benefits", force: :cascade do |t|
    t.integer  "sponsorship_level_id"
    t.integer  "benefit_id"
    t.integer  "code_type_id"
    t.integer  "max_uses"
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorship_levels_benefits", ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id", using: :btree
  add_index "sponsorship_levels_benefits", ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id", using: :btree

  create_table "sponsorships", force: :cascade do |t|
    t.integer  "conference_id",        null: false
    t.integer  "sponsor_id",           null: false
    t.integer  "sponsorship_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true, using: :btree
  add_index "sponsorships", ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true, using: :btree

  create_table "sponsorships", force: :cascade do |t|
    t.integer  "conference_id",        null: false
    t.integer  "sponsor_id",           null: false
    t.integer  "sponsorship_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true, using: :btree
  add_index "sponsorships", ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true, using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_answers", force: :cascade do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_answers", ["question_id", "option_id"], name: "survey_answers_question_option_id_idx", using: :btree

  create_table "survey_attempts", force: :cascade do |t|
    t.integer "participant_id"
    t.string  "participant_type"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_options", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "weight",      default: 0
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.integer  "survey_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "imported",   default: false
  end

  create_table "survey_surveys", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "attempts_number", default: 0
    t.boolean  "finished",        default: false
    t.boolean  "active",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "targets", force: :cascade do |t|
    t.integer  "conference_id"
    t.integer  "campaign_id"
    t.date     "due_date"
    t.integer  "target_count"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", force: :cascade do |t|
    t.integer  "conference_id"
    t.integer  "campaign_id"
    t.date     "due_date"
    t.integer  "target_count"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_group_benefits", force: :cascade do |t|
    t.integer  "ticket_group_id", null: false
    t.string   "name",            null: false
    t.text     "description",     null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_group_benefits_tickets", id: false, force: :cascade do |t|
    t.integer "ticket_group_benefit_id", null: false
    t.integer "ticket_id",               null: false
  end

  add_index "ticket_group_benefits_tickets", ["ticket_group_benefit_id", "ticket_id"], name: "tg_benefit_tix_idx", unique: true, using: :btree

  create_table "ticket_groups", force: :cascade do |t|
    t.integer  "conference_id"
    t.string   "name"
    t.string   "description"
    t.integer  "position"
    t.text     "additional_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_groups", ["conference_id"], name: "index_ticket_groups_on_conference_id", using: :btree

  create_table "ticket_purchases", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "conference_id"
    t.boolean  "paid",                    default: false
    t.datetime "created_at"
    t.integer  "quantity",                default: 1
    t.integer  "user_id"
    t.integer  "payment_id"
    t.integer  "code_id"
    t.integer  "event_id"
    t.string   "pending_event_tickets"
    t.integer  "purchase_price_cents",    default: 0,     null: false
    t.string   "purchase_price_currency", default: "USD", null: false
  end

  add_index "ticket_purchases", ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id", using: :btree
  add_index "ticket_purchases", ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id", using: :btree
  add_index "ticket_purchases", ["event_id"], name: "index_ticket_purchases_on_event_id", using: :btree
  add_index "ticket_purchases", ["event_id"], name: "index_ticket_purchases_on_event_id", using: :btree

  create_table "ticket_purchases", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "conference_id"
    t.boolean  "paid",                    default: false
    t.datetime "created_at"
    t.integer  "quantity",                default: 1
    t.integer  "user_id"
    t.integer  "payment_id"
    t.integer  "code_id"
    t.integer  "event_id"
    t.string   "pending_event_tickets"
    t.integer  "purchase_price_cents",    default: 0,     null: false
    t.string   "purchase_price_currency", default: "USD", null: false
  end

  add_index "ticket_purchases", ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id", using: :btree
  add_index "ticket_purchases", ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id", using: :btree
  add_index "ticket_purchases", ["event_id"], name: "index_ticket_purchases_on_event_id", using: :btree
  add_index "ticket_purchases", ["event_id"], name: "index_ticket_purchases_on_event_id", using: :btree

  create_table "ticket_scannings", force: :cascade do |t|
    t.integer  "physical_ticket_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "ticket_scannings", force: :cascade do |t|
    t.integer  "physical_ticket_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "conference_id"
    t.string  "title",                                     null: false
    t.text    "description"
    t.integer "price_cents",               default: 0,     null: false
    t.string  "price_currency",            default: "USD", null: false
    t.boolean "hidden",                    default: false
    t.integer "position"
    t.integer "ticket_group_id"
    t.string  "short_title"
    t.integer "early_bird_price_cents",    default: 0,     null: false
    t.string  "early_bird_price_currency", default: "USD", null: false
    t.integer "ticket_type",               default: 0
    t.date    "start_date"
    t.date    "end_date"
  end

  add_index "tickets", ["ticket_group_id"], name: "index_tickets_on_ticket_group_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer "conference_id"
    t.string  "title",                                     null: false
    t.text    "description"
    t.integer "price_cents",               default: 0,     null: false
    t.string  "price_currency",            default: "USD", null: false
    t.boolean "hidden",                    default: false
    t.integer "position"
    t.integer "ticket_group_id"
    t.string  "short_title"
    t.integer "early_bird_price_cents",    default: 0,     null: false
    t.string  "early_bird_price_currency", default: "USD", null: false
    t.integer "ticket_type",               default: 0
    t.date    "start_date"
    t.date    "end_date"
  end

  add_index "tickets", ["ticket_group_id"], name: "index_tickets_on_ticket_group_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "guid",        null: false
    t.string   "name",        null: false
    t.text     "description"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string   "guid",        null: false
    t.string   "name",        null: false
    t.text     "description"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "email_public"
    t.text     "biography"
    t.string   "nickname"
    t.string   "affiliation"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "mobile"
    t.string   "tshirt"
    t.string   "languages"
    t.text     "volunteer_experience"
    t.boolean  "is_admin",               default: false
    t.string   "username"
    t.boolean  "is_disabled",            default: false
    t.string   "avatar"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "slug"
    t.boolean  "guest",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "users_roles", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "vchoices", force: :cascade do |t|
    t.integer "vday_id"
    t.integer "vposition_id"
  end

  create_table "vchoices", force: :cascade do |t|
    t.integer "vday_id"
    t.integer "vposition_id"
  end

  create_table "vdays", force: :cascade do |t|
    t.integer  "conference_id"
    t.date     "day"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vdays", force: :cascade do |t|
    t.integer  "conference_id"
    t.date     "day"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "guid"
    t.string   "name"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "street"
    t.string   "postalcode"
    t.string   "city"
    t.string   "country"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "conference_id"
    t.string   "picture"
    t.string   "state"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "guid"
    t.string   "name"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "street"
    t.string   "postalcode"
    t.string   "city"
    t.string   "country"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "conference_id"
    t.string   "picture"
    t.string   "state"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
    t.integer  "conference_id"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
    t.integer  "conference_id"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "visits", force: :cascade do |t|
    t.uuid     "visitor_id"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree
  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

  create_table "visits", force: :cascade do |t|
    t.uuid     "visitor_id"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree
  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "vpositions", force: :cascade do |t|
    t.integer  "conference_id"
    t.string   "title",         null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vpositions", force: :cascade do |t|
    t.integer  "conference_id"
    t.string   "title",         null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "benefit_responses", "benefits"
  add_foreign_key "benefit_responses", "conferences"
  add_foreign_key "benefit_responses", "public.benefits", column: "benefit_id"
  add_foreign_key "benefit_responses", "public.conferences", column: "conference_id"
  add_foreign_key "benefit_responses", "public.sponsorships", column: "sponsorship_id"
  add_foreign_key "benefit_responses", "sponsorships"
  add_foreign_key "benefit_responses", "benefits"
  add_foreign_key "benefit_responses", "conferences"
  add_foreign_key "benefit_responses", "public.benefits", column: "benefit_id"
  add_foreign_key "benefit_responses", "public.conferences", column: "conference_id"
  add_foreign_key "benefit_responses", "public.sponsorships", column: "sponsorship_id"
  add_foreign_key "benefit_responses", "sponsorships"
  add_foreign_key "benefits", "conferences"
  add_foreign_key "benefits", "public.conferences", column: "conference_id"
  add_foreign_key "benefits", "conferences"
  add_foreign_key "benefits", "public.conferences", column: "conference_id"
  add_foreign_key "codes", "code_types"
  add_foreign_key "codes", "conferences"
  add_foreign_key "codes", "public.code_types", column: "code_type_id"
  add_foreign_key "codes", "public.conferences", column: "conference_id"
  add_foreign_key "codes", "public.sponsors", column: "sponsor_id"
  add_foreign_key "codes", "sponsors"
  add_foreign_key "codes", "code_types"
  add_foreign_key "codes", "conferences"
  add_foreign_key "codes", "public.code_types", column: "code_type_id"
  add_foreign_key "codes", "public.conferences", column: "conference_id"
  add_foreign_key "codes", "public.sponsors", column: "sponsor_id"
  add_foreign_key "codes", "sponsors"
  add_foreign_key "codes_tickets", "codes"
  add_foreign_key "codes_tickets", "public.codes", column: "code_id"
  add_foreign_key "codes_tickets", "public.tickets", column: "ticket_id"
  add_foreign_key "codes_tickets", "tickets"
  add_foreign_key "codes_tickets", "codes"
  add_foreign_key "codes_tickets", "public.codes", column: "code_id"
  add_foreign_key "codes_tickets", "public.tickets", column: "ticket_id"
  add_foreign_key "codes_tickets", "tickets"
  add_foreign_key "conference_team_members", "conferences"
  add_foreign_key "conference_team_members", "refinery_team_members"
  add_foreign_key "conferences", "conference_groups"
  add_foreign_key "conferences", "conference_groups"
  add_foreign_key "conferences_codes", "codes"
  add_foreign_key "conferences_codes", "conferences"
  add_foreign_key "conferences_codes", "public.codes", column: "code_id"
  add_foreign_key "conferences_codes", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_codes", "codes"
  add_foreign_key "conferences_codes", "conferences"
  add_foreign_key "conferences_codes", "public.codes", column: "code_id"
  add_foreign_key "conferences_codes", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_policies", "conferences"
  add_foreign_key "conferences_policies", "policies"
  add_foreign_key "conferences_policies", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_policies", "public.policies", column: "policy_id"
  add_foreign_key "conferences_policies", "conferences"
  add_foreign_key "conferences_policies", "policies"
  add_foreign_key "conferences_policies", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_policies", "public.policies", column: "policy_id"
  add_foreign_key "events", "public.tickets", column: "ticket_id"
  add_foreign_key "events", "tickets"
  add_foreign_key "events", "public.tickets", column: "ticket_id"
  add_foreign_key "events", "tickets"
  add_foreign_key "payment_methods", "conferences"
  add_foreign_key "physical_tickets", "events"
  add_foreign_key "physical_tickets", "public.events", column: "event_id"
  add_foreign_key "physical_tickets", "public.registrations", column: "registration_id"
  add_foreign_key "physical_tickets", "registrations"
  add_foreign_key "physical_tickets", "users"
  add_foreign_key "physical_tickets", "events"
  add_foreign_key "physical_tickets", "public.events", column: "event_id"
  add_foreign_key "physical_tickets", "public.registrations", column: "registration_id"
  add_foreign_key "physical_tickets", "registrations"
  add_foreign_key "physical_tickets", "users"
  add_foreign_key "policies", "conferences"
  add_foreign_key "policies", "public.conferences", column: "conference_id"
  add_foreign_key "policies", "conferences"
  add_foreign_key "policies", "public.conferences", column: "conference_id"
  add_foreign_key "polls", "conferences"
  add_foreign_key "polls", "survey_surveys", column: "survey_id"
  add_foreign_key "refinery_sponsors", "sponsorship_levels"
  add_foreign_key "sponsors_users", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsors_users", "sponsors"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsors_users", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsors_users", "sponsors"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsorship_infos", "conferences"
  add_foreign_key "sponsorship_infos", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorship_infos", "conferences"
  add_foreign_key "sponsorship_infos", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorship_levels_benefits", "benefits"
  add_foreign_key "sponsorship_levels_benefits", "public.benefits", column: "benefit_id"
  add_foreign_key "sponsorship_levels_benefits", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorship_levels_benefits", "sponsorship_levels"
  add_foreign_key "sponsorship_levels_benefits", "benefits"
  add_foreign_key "sponsorship_levels_benefits", "public.benefits", column: "benefit_id"
  add_foreign_key "sponsorship_levels_benefits", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorship_levels_benefits", "sponsorship_levels"
  add_foreign_key "sponsorships", "conferences"
  add_foreign_key "sponsorships", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorships", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsorships", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorships", "sponsors"
  add_foreign_key "sponsorships", "sponsorship_levels"
  add_foreign_key "sponsorships", "conferences"
  add_foreign_key "sponsorships", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorships", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsorships", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorships", "sponsors"
  add_foreign_key "sponsorships", "sponsorship_levels"
  add_foreign_key "ticket_group_benefits", "ticket_groups"
  add_foreign_key "ticket_group_benefits_tickets", "ticket_group_benefits"
  add_foreign_key "ticket_group_benefits_tickets", "tickets"
  add_foreign_key "ticket_groups", "conferences"
  add_foreign_key "ticket_purchases", "codes"
  add_foreign_key "ticket_purchases", "events"
  add_foreign_key "ticket_purchases", "public.codes", column: "code_id"
  add_foreign_key "ticket_purchases", "public.events", column: "event_id"
  add_foreign_key "ticket_purchases", "codes"
  add_foreign_key "ticket_purchases", "events"
  add_foreign_key "ticket_purchases", "public.codes", column: "code_id"
  add_foreign_key "ticket_purchases", "public.events", column: "event_id"
  add_foreign_key "tickets", "ticket_groups"
  add_foreign_key "tickets", "ticket_groups"
end
