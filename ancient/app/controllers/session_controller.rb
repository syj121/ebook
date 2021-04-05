class SessionController < AuthController

  skip_before_action :authenticate_user!, except: [:logout] 

	def login 
    user = User.find_by(login_name: params[:username])
    if user && user.md5_password?(params[:password])
      user.change_token(true)
      render json: { 
        success: true, 
        msg: "登录成功", 
        result: {
          token: user.token,
          real_name: user.login_name,
        }
      }
    else
      render json: {
        success: false, 
        msg: "用户名或密码错误！"
      }
    end
	end

  def logout
    @user.change_token(true)
    render json: {
      success: true,
      msg: "退出成功！"
    }
  end

  #是否需要验证码
  def step_captcha
    render json: {success: true, msg: "不需要验证码", resulr: {stepCode: false}}
  end
	
end