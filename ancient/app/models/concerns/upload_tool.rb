module UploadTool

  #保存图片，路径存储到object对应的路径下
  def save_file_by_type(file, t, opts = {})
    pic = PicUploader.new
    pic.store_dir = path(t)
    pic.store!(file)
    if obj = opts[:obj]
      obj.send("#{t}=", pic.filename)
      obj.save
    end
    pic.filename
  end

  def file_path(col)
    #文件名
    fname = self.send("#{col}")
    return default_url(col) if fname.blank?
    #提取参数名
    fpath = col.to_s.gsub(/_path|_url/,"")
    #文件路径
    path = Base64.encode64("#{self.class.name}/#{self.id}/#{fpath}/#{fname}")
    "/show_file/#{path}"
  end

  def default_url(type)
    #用户的图片路口
    if self.class.name == "User"
      case type.to_s
      when "avatar_url"
      else
        "/avatar2.jpg"
      end
    end
  end

  ######################################  tools ####################################
  #文件保存路径
  #object 文件所属对象
  #t  对象的某种属性类别
  def path(t, opts = {})
    pstr = "#{Rails.root}/uploads/#{self.class.name.underscore}/#{self.id}"
    pstr = "#{pstr}/#{t}" if t.present?
    pstr
  end

end