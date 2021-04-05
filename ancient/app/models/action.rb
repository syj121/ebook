class Action < ApplicationRecord

  belongs_to :permission
  
  BASE_ACTIONS = {add: "新增", query: "查询", get: "详情", update: "修改", delete: "删除"}
  
  def self.initActions(permission)
    BASE_ACTIONS.each do |k,v|
      a = Action.find_or_initialize_by(permission_id: permission.id, no: k)
      a.name = v
      a.save
    end
  end

end