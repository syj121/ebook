class PermissionsController < AuthController

  def index
    if params[:roleId].present?
      permissions = Role.find(params[:roleId]).permissions
    else
      permissions = Permission.all
    end 
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

  def create
    permission = Permission.new
    permission.name = params[:name]
    permission.no = params[:no]
    permission.save
    render json: {success: true, msg: "创建成功"}
  end

  def update
    permission = Permission.find_by(id: params[:id])
    return render json: {success: false, msg: "权限菜单已不存在！"} unless permission
    permission.name = params[:name]
    permission.no = params[:no]
    permission.save
    render json: {success: true, msg: "更新成功"}
  end

  def destroy
    permission = Permission.find_by(id: params[:id])
    render json: {success: permission.destroy}
  end
  
end