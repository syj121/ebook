class User < ApplicationRecord
  
  STATUS = {1 => "正常", -1 => "停用"}
  DEFAULT_STATUS = -1
  DELEGATE_COLUMNS = [:nick_name, :email, :mobile, :personal_desc, :avatar_url]

  include StatusTool
  include DigestTool
  include UploadTool

  #所有角色
  has_many :role_users, dependent: :destroy
  has_many :roles, through: :role_users
  #当前角色
  belongs_to :role, class_name: "Role", foreign_key: "current_role_id", optional: true
  #详细信息
  has_one :info, class_name: "UserInfo"
  accepts_nested_attributes_for :info

  delegate :permissions, :to => :role
  DELEGATE_COLUMNS.each do |dc|
    delegate dc, :to => :info, allow_nil: true
    define_method "#{dc}=" do |t|
      info_attributes = {
        dc => t
      }
      info.assign_attributes(info_attributes)
    end
  end

  before_save :change_token

  # 修改token
  def change_token(force = false)
    if self.changed? || force
      self.token = "#{Time.now.to_s(:number)}_#{SecureRandom.hex}"
      self.save if force
      self.token
    end
  end

end
