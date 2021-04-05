class LogsController < ApplicationController
  
  def error
    puts "#{params}"
    render json: {success: true, code: 200, msg: "错误信息已记录！"}
  end

end