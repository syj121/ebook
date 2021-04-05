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

ActiveRecord::Schema.define(version: 2021_01_18_083720) do

  create_table "actions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "permission_id"
    t.string "name", comment: "权限名"
    t.string "remark", comment: "权限说明"
    t.string "no", comment: "action "
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_actions_on_permission_id"
  end

  create_table "permission_hierarchies", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "permission_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "permission_desc_idx"
  end

  create_table "permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", comment: "菜单名"
    t.string "no", comment: "编号"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "no"], name: "index_permissions_on_name_and_no", unique: true
  end

  create_table "role_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "role_permission_id"
    t.integer "action_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_permission_id", "action_id"], name: "index_role_actions_on_role_permission_id_and_action_id", unique: true
  end

  create_table "role_permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "role_id"], name: "index_role_users_on_user_id_and_role_id", unique: true
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", comment: "角色名"
    t.text "remark", comment: "角色说明"
    t.string "no", comment: "编号"
    t.integer "status", default: 1, comment: "角色状态"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_imgs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "avatar_url", comment: "图片地址"
    t.string "name", comment: "图片名"
    t.string "contet_type", comment: "图片类型"
  end

  create_table "user_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "nick_name", comment: "昵称"
    t.string "email", comment: "邮箱"
    t.string "mobile", comment: "手机号"
    t.string "avatar_url", comment: "头像"
    t.text "personal_desc", comment: "个性化描述"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_infos_on_user_id", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login_name", null: false, comment: "登录名"
    t.string "password_digest", comment: "密码"
    t.string "token", comment: "登录token"
    t.integer "current_role_id", default: 2, comment: "当前角色"
    t.integer "status", default: 1, comment: "状态"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login_name"], name: "index_users_on_login_name", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

end
