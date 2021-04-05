class Role < ApplicationRecord

  has_many :role_users, dependent: :destroy
  has_many :users

  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  has_many :role_actions, dependent: :destroy
  has_many :actions, through: :role_actions

  #角色的权限hash
  def hash_permission
    h = {
      id: self.id,
      name: self.name,
      describe: self.remark,
      status: self.status,
      creatorId: "system",
      creatorTime: self.created_at.to_s(:number),
      deleted: 0,
      permissions: self.role_permissions.includes(:permission, :actions).map { |role_permission|  
        permission = role_permission.permission
        actions = role_permission.actions.map { |action| 
          {
            action: action.no,
            defaultCheck: false,
            describe: action.remark
          }
        }
        {
          roleId: self.no,
          permissionId: permission.no,
          permissionName: permission.name,
          actions: actions.to_json,
          actionEntitySet: actions
        }
      }
    }
  end

end
