class CustomController < ApplicationController
  
  #错误
  def save_error_logger
    render json: {success: false, code: 500, msg: "异常"}
  end

end