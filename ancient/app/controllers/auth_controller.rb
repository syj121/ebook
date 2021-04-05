class AuthController < ApplicationController
  
  before_action :authenticate_user!

  def authenticate_user!
    @user = User.find_by(token: request.headers["Access-Token"])
    if @user.blank?
      return render json: {success: false, msg: "请先登录！"}
    end
    @role = @user.role
    if @role.blank?
      return render json: {success: false, msg: "该用户暂无角色！"}
    end
  end
  
  def current_user
    @user
  end
    
end