class UsersController < AuthController

  def index
    users = User.all
    [:status, :login_name, :id].each do |k|
      next if params[k].blank?
      users = users.where( k => params[k])
    end
    users = users.page(params[:pageNo]).per(params[:pageSize]).includes(:roles)
    roles = Hash[Role.pluck(:id, :name)]
    render json: {
      success: true,
      code: 200,
      result: {
        pageNo: params[:pageNo].to_i,
        totalCount: User.count,
        roles: roles,
        defaultStatus: User::DEFAULT_STATUS,
        data: users.map { |user| {
          id: user.id,
          roleIds: user.role_ids.map(&:to_s),  #只有返回字符串，编辑页面才能展示默认值
          roleNames: user.roles.map(&:name).join("，"),
          loginName: user.login_name,
          roleName: user.role.try(:name),
          status: user.status,
          createdAt: user.created_at.to_s,
          updatedAt: user.updated_at.to_s
        } },
        statusMap: User::STATUS
      }
    }
  end
  
  def info
    render json: {
      success: true, 
      code: 200,
      result: {
        id: @user.token,
        name: @user.login_name,
        username: @user.nick_name,
        password: "",
        avatar: @user.file_path(:avatar_url),
        status: 1,
        telephone: @user.mobile,
        lastLoginIp: '27.154.74.117',
        lastLoginTime: 1534837621348,
        creatorId: @user.id,
        createTime: 1497160610259,
        merchantCode: 'TLif2btpzg079h15bk',
        deleted: 0,
        roleId: @role.no,
        role: @role.hash_permission,
        personalDesc: @user.personal_desc,
        email: @user.email
      }
    }
  end

  def create
    user = User.new
    user.login_name = params[:loginName]
    user.password = "12345678"
    user.role_ids = params[:roleIds]
    user.status = params[:status]
    user.save
    render json: {success: true, msg: "创建成功"}
  end

  def update
    user = User.find_by(id: params[:id])
    return render json: {success: false, msg: "用户不存在！"} unless user
    user.status = params[:status]
    user.login_name = params[:loginName]
    user.role_ids = params[:roleIds]
    user.save
    render json: {success: true, msg: "更新成功"}
  end

  #设置个性化信息
  def setUserInfo
    puts_log params
    @info = @user.info || @user.build_info
    @info.nick_name = params[:username]
    @info.email = params[:email]
    @info.personal_desc = params[:personalDesc]
    @info.avatar_url = @user.save_file_by_type(params[:avatar], "avatar") if params[:avatar]
    @info.save
    render json: {success: true, msg: "设置成功！"}
  end

  def setPic
    
  end

  def destroy
    user = User.find_by(id: params[:id])
    render json: {success: user.destroy}
  end
  
end