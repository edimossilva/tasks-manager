# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_401_051_651) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'task_in_lists', force: :cascade do |t|
    t.boolean 'checked'
    t.bigint 'task_list_id'
    t.bigint 'task_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['task_id'], name: 'index_task_in_lists_on_task_id'
    t.index ['task_list_id'], name: 'index_task_in_lists_on_task_list_id'
  end

  create_table 'task_lists', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.integer 'frequence_type'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_task_lists_on_user_id'
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'password_digest'
    t.integer 'access_level'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'task_in_lists', 'task_lists'
  add_foreign_key 'task_in_lists', 'tasks'
  add_foreign_key 'task_lists', 'users'
end
