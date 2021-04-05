# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 新增角色
role = Role.find_or_initialize_by(id: 1)
role.update(name: "超级管理员", no: "admin", remark: "拥有系统全部权限")
role = Role.find_or_initialize_by(id: 2)
role.update(name: "普通用户", no: "users", remark: "普通浏览权限")

#新增用户
Role.all.each do |role|
  id = role.id
  user = User.find_or_initialize_by(id: id)
  user.login_name = role.no
  user.password = "12345678"
  user.current_role_id = id
  user.save

  ru = RoleUser.find_or_initialize_by(id: id)
  ru.role_id = id
  ru.user_id = id
  ru.save
end

permission_index = 1
role_permission_index = 1
action_index = 1
role_action_index = 1
{dashboard: "dashboard", users: "用户管理"}.each do |permission_no, permission_name|
  permission = Permission.find_or_initialize_by(id: permission_index)
  permission.name = permission_name
  permission.no = permission_no
  permission.parent = Permission.first
  permission.save
  permission_index += 1
  #菜单所有权限
  {add: "新增", query: "查询", get: "详情", update: "修改", delete: "删除"}.each do |action_no, action_name|
    action = Action.find_or_initialize_by(id: action_index)
    action.permission_id = permission.id
    action.name = action_name
    action.no = action_no
    action.save
    action_index += 1
  end

  #超级管理员的菜单
  role_permission = RolePermission.find_or_initialize_by(id: role_permission_index)
  role_permission.role_id = 1
  role_permission.permission_id = permission.id
  role_permission.save
  role_permission_index += 1
  #超级管理员的权限
  permission.actions.each do |action|
    role_action = RoleAction.find_or_initialize_by(id: role_action_index)
    role_action.role_permission_id = role_permission.id
    role_action.action_id = action.id
    role_action.save
    role_action_index += 1
  end

  #普通用户权限
  role_permission = RolePermission.find_or_initialize_by(id: role_permission_index)
  role_permission.role_id = 2
  role_permission.permission_id = permission.id
  role_permission.save
  role_permission_index += 1
  {query: "查询", get: "详情"}.each do |action_no, action_name|
    action = permission.actions.find_by(no: action_no)
    role_action = RoleAction.find_or_initialize_by(id: role_action_index)
    role_action.role_permission_id = role_permission.id
    role_action.action_id = action.id
    role_action.save
    role_action_index += 1
  end
end