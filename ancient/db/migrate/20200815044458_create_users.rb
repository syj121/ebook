class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    #角色
    create_table :roles do |t|
      t.string :name, comment: "角色名"
      t.text :remark, comment: "角色说明"
      t.string :no, comment: "编号"
      t.integer :status, default: 1, comment: "角色状态"
      t.timestamps
    end
    #用户
    create_table :users do |t|
      t.string :login_name, null: false, comment: "登录名"
      t.string :password_digest, comment: "密码"
      t.string :token, comment: "登录token"
      t.integer :current_role_id, default: 2, comment: "当前角色"
      t.integer :status, default: 1, comment: "状态"
      t.timestamps
      t.index :login_name, unique: true
      t.index :token, unique: true
    end
    #用户 - 角色
    create_table :role_users do |t|
      t.integer :role_id
      t.integer :user_id
      t.timestamps
      t.index [:user_id, :role_id], unique: true
    end
    #菜单
    create_table :permissions do |t|
      t.string :name, comment: "菜单名"
      t.string :no, comment: "编号"
      t.integer :parent_id
      t.timestamps
      t.index [:name, :no], unique: true
    end
    create_table :permission_hierarchies, id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
      t.index [:ancestor_id, :descendant_id, :generations], name: "permission_anc_desc_idx", unique: true
      t.index :descendant_id, name: "permission_desc_idx"
    end
    #菜单权限
    create_table :actions do |t|
      t.integer :permission_id
      t.string :name, comment: "权限名"
      t.string :remark, comment: "权限说明"
      t.string :no, comment: "action "
      t.timestamps
      t.index [:permission_id]
    end
    #角色 - 菜单
    create_table :role_permissions do |t|
      t.integer :permission_id
      t.integer :role_id
      t.timestamps
    end
    #角色 - 菜单权限
    create_table :role_actions do |t|
      t.integer :role_permission_id
      t.integer :action_id
      t.timestamps
      t.index [:role_permission_id, :action_id], unique: true
    end
  end
end
