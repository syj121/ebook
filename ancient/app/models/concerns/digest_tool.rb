#require 'bcrypt'
module DigestTool
  
  extend ActiveSupport::Concern

  included do |base|
    # 所有加密字段，存储字段：字段名_digest。如，pay加密存储，存储字段：pay_digest  
    DIGEST_COLUMNS = base.column_names.select{|cn| cn =~ /_digest/}.map{|cn|cn.gsub(/_digest/, "")}
    
    DIGEST_COLUMNS.each do |dc|
      attr_accessor = dc
    end
    
    DIGEST_COLUMNS.each do |n|
      define_method n do 
        self.send "#{n}_digest"
      end
      
      define_method "#{n}=" do |psw|
        self.send "#{n}_digest=", Digest::MD5.hexdigest(psw)
      end
      
      define_method "valid_#{n}?" do |psw|
        #md5加密
        Digest::MD5.hexdigest(psw) == self.send(n)
        #BCrypt::Password.new(self.send(n)) == psw
      end
      
      define_method "md5_#{n}?" do |psw|
        self.send("#{n}_digest") == psw
      end

    end
  end
  

end