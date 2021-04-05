class RolePermission < ApplicationRecord

  belongs_to :role
  belongs_to :permission

  has_many :role_actions, dependent: :destroy
  has_many :actions, through: :role_actions

end
