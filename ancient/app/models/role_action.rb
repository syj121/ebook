class RoleAction < ApplicationRecord

  belongs_to :role_permission
  belongs_to :action
end
