class RolePermissionsController < AuthController
  before_action :get_role

  def index
    rs = []
    Permission.all.find_each do |permi|
      rs << {
        title: permi.name,
        key: permi.id.to_s,
        children: [],
      }
    end
    checked = @role.permission_ids.map(&:to_s)
    render json: {
      success: true,
      code: 200,
      result: {
        role: @role.name,
        data: rs,
        checked: checked
      }
    }
  end

  #取消/设置菜单
  def set
    rp = RolePermission.find_or_create_by(role_id: @role.id, permission_id: params[:permissionId])
    rp.destroy unless params[:checked]
    render json: {
      success: true,
      code: 200,
      msg: "操作成功",
      result: {}
    }
  end

  #取消/设置菜单权限
  def setAction
    rolePermission = RolePermission.find_by(role_id: @role.id, permission_id: params[:permissionId])
    unless rolePermission
      return render json: {
        success: false,
        code: 200, 
        msg: "暂无该菜单权限",
        result: {}
      }
    end
    ra = RoleAction.find_or_create_by(role_permission_id: rolePermission.id, action_id: params[:actionId])
    ra.destroy unless params[:selected]
    render json: {
      success: true,
      code: 200,
      msg: "操作成功",
      result: {}
    }
  end

  private
  def get_role
    @role = Role.find_by(id: params[:role_id])
  end
end