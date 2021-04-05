class ActionsController < AuthController

  before_action :get_permission

  def index
    actions = @permission.actions
    [:name].each do |k|
      next if params[k].blank?
      actions = actions.where( k => params[k])
    end
    checked = RoleAction.joins(:role_permission).where("role_permissions.role_id = ?", params[:roleId]).pluck("role_actions.action_id") if params[:roleId].present?
    actions = actions.page(params[:pageNo]).per(params[:pageSize])
    render json: {
      success: true,
      code: 200,
      result: {
        isInit: @permission.actions.exists?,
        pageNo: params[:pageNo].to_i,
        totalCount: Role.count,
        checkedActions: checked,
        data: actions.map { |action| {
          id: action.id,
          name: action.name,
          permissionName: @permission.name,
          no: action.no,
          remark: action.remark
        } }
      }
    }
  end

  def create
    action = Action.new
    action.name = params[:name]
    action.no = params[:no]
    action.permission_id = @permission.id
    action.save
    render json: {success: true, msg: "创建成功"}
  end

  def update
    action = Action.find_by(id: params[:id])
    return render json: {success: false, msg: "角色不存在！"} unless action
    action.name = params[:name]
    action.no = params[:no]
    action.permission_id = @permission.id
    action.save
    render json: {success: true, msg: "更新成功"}
  end

  def destroy
    action = Action.find_by(id: params[:id])
    render json: {success: action.destroy}
  end
  
  def initActions
    Action.initActions(@permission)
    render json: {success: true}
  end
  

  private
  def get_permission
    @permission = Permission.find_by(id: params[:permission_id])
  end
end