class RolesController < AuthController

  def index
    roles = Role.all
    [:name].each do |k|
      next if params[k].blank?
      roles = roles.where( k => params[k])
    end
    roles = roles.page(params[:pageNo]).per(params[:pageSize])
    render json: {
      success: true,
      code: 200,
      result: {
        pageNo: params[:pageNo].to_i,
        totalCount: Role.count,
        data: roles.map { |role| {
          id: role.id,
          name: role.name,
          no: role.no,
          remark: role.remark
        } }
      }
    }
  end

  def create
    role = Role.new
    role.name = params[:name]
    role.remark = params[:remark]
    role.no = params[:no]
    role.save
    render json: {success: true, msg: "创建成功"}
  end

  def update
    role = Role.find_by(id: params[:id])
    return render json: {success: false, msg: "角色不存在！"} unless role
    role.name = params[:name]
    role.remark = params[:remark]
    role.no = params[:no]
    role.save
    render json: {success: true, msg: "更新成功"}
  end

  def destroy
    role = Role.find_by(id: params[:id])
    render json: {success: role.destroy}
  end
  
  def permissions
    permissions = @role.permissions
    [:name].each do |k|
      next if params[k].blank?
      permissions = permissions.where( k => params[k])
    end
    permissions = permissions.page(params[:pageNo]).per(params[:pageSize])
    render json: {
      success: true,
      code: 200,
      result: {
        pageNo: params[:pageNo].to_i,
        totalCount: permissions.count,
        data: permissions.map { |permission| {
          id: permission.id,
          name: permission.name,
          no: permission.no
        } }
      }
    }
  end
  
end