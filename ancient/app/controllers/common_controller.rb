class CommonController < AuthController
   skip_before_action :authenticate_user!, only: [:show_file]
  
  #文件展示
  def show_file
    #"User_1_avatar_fname.png"
    path = Base64.decode64(params[:fpath])
    send_file "#{Rails.root}/uploads/#{path}"
  end

  #上传文件
  def upload_file
    otype = JSON.parse(params[:otype]) rescue {}
    #类
    klass = otype["otype"].classify.constantize rescue nil
    render json: {success: false, msg: '暂无法上传！'} if klass.nil?
    #id
    oid = otype["oid"].presence || current_user.id
    obj = klass.find_by(id: oid)
    render json: {success: false, msg: "当前对象不存在"} unless obj
    #字段
    attr = otype["attr"]
    render json: {success: false, msg: "当前对象不支持上传"} unless obj.respond_to?(attr)
    #保存图片
    obj.save_file_by_type(params[:file], attr, {obj: obj})
    #文件路径
    url = obj.file_path(attr.to_sym)
    render json: {success: true, msg: "上传成功", url: url}
  end
end